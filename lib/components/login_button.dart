import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {super.key, required this.button, required this.buttonName});
  final String buttonName;
  final Function()? button;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: button,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child:  Center(
              child: Text(
            buttonName,
            style:const  TextStyle(
                fontSize: 22,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ))),
    );
  }
}
