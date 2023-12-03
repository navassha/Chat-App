import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/widgets/modified_text.dart';
import 'package:flutter/material.dart';

class ClickContainer extends StatelessWidget {
  const ClickContainer({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(198),
      height: context.width(49),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 203, 186, 255),
        borderRadius: BorderRadius.circular(
          context.width(22),
        ),
      ),
      child: Center(
        child: StyledText(
          text: text,
          size: 18,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
