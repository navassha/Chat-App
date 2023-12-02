import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/providers/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationForHome extends ConsumerWidget {
  const BottomNavigationForHome(
      {super.key,
      required this.function,
      required this.number,
      required this.icon});
  final void Function() function;
  final int number;
  final Icon icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: function,
      child: CircleAvatar(
        radius: context.width(35),
        backgroundColor: ref.watch(bottomNavigationProvider) != number
            ? Colors.white
            : Colors.black,
        child: icon,
      ),
    );
  }
}
