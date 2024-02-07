import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.text, required this.onTap});
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:   EdgeInsets.fromLTRB(20,20,20,0),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.grey[300]),
            child: Row(children: [
              const Icon(Icons.person,size: 30,),
              const SizedBox(width: 15,),
              Text(text)
            ]),
      ),
    );
  }
}
