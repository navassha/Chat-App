import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/widgets/modified_text.dart';
import 'package:flutter/material.dart';

class GoogleLogorSign extends StatelessWidget {
  const GoogleLogorSign({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(272),
      height: context.width(53),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          context.width(22),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: context.width(19),
          ),
          SizedBox(
            height: context.width(36),
            width: context.width(38),
            child: Image.asset(
              "assets/images/Keeping Up with Google_ The One Blog to Rule Them All!.jpeg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: context.width(10),
          ),
          StyledText(
            text: text,
            size: 16,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}
