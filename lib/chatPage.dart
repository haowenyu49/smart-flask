import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with SingleTickerProviderStateMixin {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  bool isTyping = false;
  late OpenAI openAI;
  late String assistantId;
  late String threadId;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initializeOpenAI();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
  }

  Future<void> _initializeOpenAI() async {
    openAI = OpenAI.instance.build(
      token: dotenv.env['OPENAI_API_KEY']!,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true,
    );
    assistantId = dotenv.env['WATER_ASSISTANT']!;
    threadId = await initiateThread();
  }

  Future<String> initiateThread() async {
    try {
      ThreadResponse thr = await openAI.threads.v2.createThread(request: ThreadRequest());
      return thr.id;
    } catch (error) {
      // Handle error (e.g., show a message to the user)
      print("Failed to initiate thread: $error");
      return '';
    }
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    String messageText = _controller.text;
    _controller.clear();

    setState(() {
      messages.add({'text': messageText, 'isUser': true});
      isTyping = true;
    });

    _createMessage(messageText);
  }

  void _createMessage(String message) async {
    final request = CreateMessage(
      role: 'user',
      content: message,
    );

    try {
      await openAI.threads.v2.messages.createMessage(
        threadId: threadId,
        request: request,
      );

      // Now get the response from the assistant
      final response = await openAI.threads.v2.messages.listMessage(threadId: threadId);

      // Extract the actual text content from the response
      String assistantMessage = response.data.first.content.map((content) {
        if (content is TextData) {
          return content.text; // Assuming `text` is a String in `TextData`
        }
        return '';
      }).join(" ");

      setState(() {
        isTyping = false;
        messages.add({'text': assistantMessage, 'isUser': false, 'isChatGpt': true});
      });
    } catch (error) {
      // Handle error (e.g., show a message to the user)
      print("Failed to send or receive message: $error");
      setState(() {
        isTyping = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with Assistants"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUser = messages[index]['isUser'];
                bool isChatGpt = messages[index].containsKey('isChatGpt') && messages[index]['isChatGpt'];
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.grey[300] : (isChatGpt ? Colors.blue[200] : Colors.green[200]),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      messages[index]['text'],
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          if (isTyping)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 8.0),
                  Text("Assistant is typing..."),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
