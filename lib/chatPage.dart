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

    print("OpenAI initialized with threadId: $threadId"); // Print threadId for verification
  }

  Future<String> initiateThread() async {
    try {
      ThreadResponse thr = await openAI.threads.v2.createThread(request: ThreadRequest());
      print("Thread created with ID: ${thr.id}"); // Print to verify thread creation
      return thr.id;
    } catch (error) {
      print("Failed to initiate thread: $error"); // Print the error if thread creation fails
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
      // Step 1: Create or use existing thread
      if (threadId.isEmpty) {
        threadId = await initiateThread();
        print("Created new thread with ID: $threadId");
      }

      // Step 2: Create and send the message
      final myMessage = await openAI.threads.v2.messages.createMessage(
        threadId: threadId,
        request: request,
      );
      print("Message sent successfully: ${myMessage.content}");

      // Step 3: Create a run to get the assistant's response
      final myRun = await openAI.threads.v2.runs.createRun(
        threadId: threadId,
        request: CreateRun(assistantId: assistantId)
      );
      print("Run started with ID: ${myRun.id}");

      // Step 4: Poll the run status until completed
      var retrievedRun;
      do {
        retrievedRun = await openAI.threads.v2.runs.retrieveRun(
          threadId: threadId,
          runId: myRun.id,
        );
        print("Current run status: ${retrievedRun.status}");
        await Future.delayed(Duration(seconds: 1)); // Add delay to avoid spamming the API
      } while (retrievedRun.status == "queued" || retrievedRun.status == "in_progress");

      // Step 5: Once the run is completed, retrieve the assistant's response
      if (retrievedRun.status == "completed") {
        final allMessages = await openAI.threads.v2.messages.listMessage(threadId: threadId);
        String assistantMessage = allMessages.data.first.content.map((content) {
          if (content is TextData) {
            return content.text;
          }
          return '';
        }).join(" ");
        print("Assistant's response: $assistantMessage");

        // Update the UI with the assistant's message
        setState(() {
          isTyping = false;
          messages.add({'text': assistantMessage, 'isUser': false, 'isChatGpt': true});
        });
      } else {
        print("Run did not complete successfully, status: ${retrievedRun.status}");
        setState(() {
          isTyping = false;
        });
      }
    } catch (error) {
      // Handle error and print it
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
