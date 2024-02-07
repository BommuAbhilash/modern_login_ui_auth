import 'package:flutter/material.dart';
import 'package:modern_login_ui_auth/components/chat_page.dart';
import 'package:modern_login_ui_auth/components/home_drawer.dart';
import 'package:modern_login_ui_auth/components/user_tile.dart';
import 'package:modern_login_ui_auth/services/auth_services.dart';
import 'package:modern_login_ui_auth/services/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  String title(String name) {
    String s = name;

    String result = s.substring(0, s.indexOf('@'));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text(title(authService.getCurrentUser()!.email.toString()))),
      drawer: const HomeDrawer(),
      body: _buildUserList(), 
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading...");
          }
          return ListView(
            children: snapshot.data!.map<Widget>((userData) {
              return _buildUserListItem(userData, context);
            }).toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              );
            },
          ));
        },
      );
    } else {
      return Container();
    }
  }
}
