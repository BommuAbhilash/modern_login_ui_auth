import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modern_login_ui_auth/components/chat_bubble.dart';
import 'package:modern_login_ui_auth/components/input_fields.dart';
import 'package:modern_login_ui_auth/services/auth_services.dart';
import 'package:modern_login_ui_auth/services/chat_service.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});
  final String receiverEmail;
  final String receiverID;

  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);

      //clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(child: _buildMessageList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        //errors
        if (snapshot.hasError) {
          return const Text("error");
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("loading..");
        }

        //return List view
       
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
       crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"],isCurrentUser: isCurrentUser),
          // Text(data["message"]),
        ],
      ),
    );
  }

  //build messages input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            child: InputFields(
                controller: _messageController,
                hintText: "Type a message",
                obscureText: false),
          ),
          Container(
              decoration: const BoxDecoration(
                  color: Colors.green, shape: BoxShape.circle),
              margin: const EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: sendMessage, icon: const Icon(Icons.arrow_upward)))
        ],
      ),
    );
  }
}
