import 'package:flutter/material.dart';

class InputFields extends StatelessWidget {
  const InputFields({
    super.key, required this.controller, required this.hintText, required this.obscureText,
  });
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  // final TextEditingController controller;
  // final bool obscureText;
  // final const hinText;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        
        decoration: InputDecoration(
          focusColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,style: BorderStyle.solid),
          
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white,width: 0.5)
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
        ),
        
      ),
    );
  }
}
