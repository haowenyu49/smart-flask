import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with SingleTickerProviderStateMixin {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  bool isTyping = false;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
  }

  void _sendMessage() {
    String message = _controller.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        messages.add({"text": message, "isUser": true});
      });
      _controller.clear();
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
      _getResponse(message);
    }
  }

  void _getResponse(String message) async {
    setState(() {
      isTyping = true;
    });

    // Placeholder for getting response from ChatGPT
    String chatGptResponse = await getChatGptResponse(message);
    setState(() {
      messages.add({"text": chatGptResponse, "isUser": false, "isChatGpt": true});
      isTyping = false;
    });

    // Placeholder for getting response from custom assistant
    String customAssistantResponse = await getCustomAssistantResponse(message);
    setState(() {
      messages.add({"text": customAssistantResponse, "isUser": false, "isChatGpt": false});
    });
  }

  Future<String> getChatGptResponse(String message) async {
    // Mock response for now
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay
    return "ChatGPT response for: $message";
  }

  Future<String> getCustomAssistantResponse(String message) async {
    // Mock response for now
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay
    return "Custom assistant response for: $message";
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

void main() {
  runApp(MaterialApp(
    home: ChatPage(),
  ));
}
