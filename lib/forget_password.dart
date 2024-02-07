import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modern_login_ui_auth/components/input_fields.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();

  void resetPassword() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
          Navigator.pop(context);
        return wrongEmail("check your email");
      
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      return wrongEmail(e.code);
    }
  }

  void wrongEmail(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: AlertDialog(
              title: Text(message),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Reset your password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          const SizedBox(
            height: 20,
          ),
          InputFields(
            controller: emailController,
            hintText: "enter your email",
            obscureText: false,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue[100],
            ),
            child: InkWell(
              onTap: resetPassword,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Reset password",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
