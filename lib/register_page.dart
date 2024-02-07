import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modern_login_ui_auth/components/image_asset.dart';
import 'package:modern_login_ui_auth/components/input_fields.dart';
import 'package:modern_login_ui_auth/components/login_button.dart';
import 'package:modern_login_ui_auth/services/auth_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.onTap});
  final Function()? onTap;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userNameController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void button() async {
   
    
    if (passwordController.text == confirmPasswordController.text) {
      try {
        final authService = AuthService();
        await authService.createUserWithEmailAndPassword(
            userNameController.text, passwordController.text);
      } on FirebaseAuthException catch (e) {
        
        wrongEmail(e.code);
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: AlertDialog(
                title: Text("Passwords didn't match"),
                
              ),
            );
          });
    }
    // Navigator.pop(context);
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
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_open,
                    size: 100,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Let's create an account for you",
                style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              ),
              const SizedBox(
                height: 20,
              ),
              InputFields(
                controller: userNameController,
                hintText: "Email",
                obscureText: false,
              ),
              const SizedBox(
                height: 15,
              ),
              InputFields(
                controller: passwordController,
                hintText: "password",
                obscureText: true,
              ),
              const SizedBox(
                height: 15,
              ),
              InputFields(
                controller: confirmPasswordController,
                hintText: "confirm password",
                obscureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 30,
              ),
              LoginButton(
                button: () {
                  button();
                },
                buttonName: "Sign Up",
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      height: 1,
                      color: Colors.black,
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text("Or continue with",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[500])),
                    ),
                    const Expanded(
                        child: Divider(
                      height: 1,
                      color: Colors.black,
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageAsset(image: "assets/goodle.png"),
                  SizedBox(
                    width: 20,
                  ),
                  ImageAsset(image: "assets/ios.png"),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member? ",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login now",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
