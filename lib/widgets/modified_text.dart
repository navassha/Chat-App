import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/providers/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StyledText extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      overflow: TextOverflow.ellipsis,
      text,
      style: TextStyle(
        fontSize: context.width(size),
        fontWeight: fontWeight,
        fontFamily: 'Poppins',
        color:
            ref.watch(darkmodeProvider) == true ? Colors.white : Colors.black,
      ),
    );
  }
}
