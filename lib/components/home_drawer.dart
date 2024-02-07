import 'package:flutter/material.dart';
import 'package:modern_login_ui_auth/services/auth_services.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});
  void logout() {
    final authService = AuthService();
    authService.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(child: Icon(Icons.message)),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text("settings"),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  logout();
                },
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("logout"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
