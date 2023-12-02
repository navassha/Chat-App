import 'package:chat_app/extensions/responsive.dart';
import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(
      {super.key,
      required this.text,
      required this.size,
      this.fontWeight,
      this.color});
  final String text;
  final double size;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: TextOverflow.ellipsis,
      text,
      style: TextStyle(
        fontSize: context.width(size),
        fontWeight: fontWeight,
        fontFamily: 'inter',
        color: color,
      ),
    );
  }
}
