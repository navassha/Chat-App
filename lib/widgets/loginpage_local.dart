// this is the row of Show password and forgot password row

import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/providers/password_provider.dart';
import 'package:chat_app/widgets/modified_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPageNavigator extends StatelessWidget {
  const SignUpPageNavigator(
      {super.key, required this.text, required this.longText});

  final String text;
  final String longText;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: context.width(34),
        ),
        StyledText(
          text: longText,
          size: context.width(16),
          fontWeight: FontWeight.w500,
        ),
        SizedBox(
          width: context.width(5),
        ),
        GestureDetector(
          onTap: () {},
          child: StyledText(
            text: text,
            size: context.width(16),
            color: const Color(0xff46AFFB),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// if user dont have an accont user can signup this widget is for user sign up

class ShowpassRow extends ConsumerWidget {
  const ShowpassRow({
    super.key,
    required this.showpassword,
  });

  final bool showpassword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        SizedBox(
          width: context.width(26),
        ),
        IconButton(
          onPressed: () {
            ref.read(showPassWordProvider.notifier).state = !showpassword;
          },
          icon: ref.watch(showPassWordProvider) == false
              ? Icon(
                  CupertinoIcons.square,
                  size: context.width(20),
                )
              : Icon(
                  CupertinoIcons.checkmark_square_fill,
                  size: context.width(20),
                  color: Colors.green,
                ),
        ),
        const StyledText(
          text: "Show Password",
          size: 16,
          fontWeight: FontWeight.w600,
        ),
        const Spacer(),
        StyledText(
          text: "Forgot Password?",
          size: context.width(16),
          fontWeight: FontWeight.w600,
          color: const Color(0xff46AFFB),
        ),
        SizedBox(
          width: context.width(34),
        )
      ],
    );
  }
}
