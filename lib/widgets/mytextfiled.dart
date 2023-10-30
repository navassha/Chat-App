import 'package:chat_app/extensions/responsive.dart';
import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({
    this.obscureText = false,
    required this.hintText,
    required this.controller,
    super.key,
  });
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.width(61),
      width: context.width(361),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        cursorHeight: context.width(20),
        cursorColor: Colors.black,
        style: TextStyle(
          fontSize: context.width(20),
          fontFamily: 'inter',
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontFamily: 'inter',
              fontWeight: FontWeight.w600,
              fontSize: context.width(18)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              context.width(22),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              context.width(22),
            ),
          ),
        ),
      ),
    );
  }
}
