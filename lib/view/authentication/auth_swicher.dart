import 'package:chat_app/providers/authentication.dart';

import 'package:chat_app/view/getstarted/getstarted_page.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Authswither extends ConsumerWidget {
  const Authswither({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authstatechangeProvider).when(
          data: (data) {
            if (data == null) {
              return GetStarted();
            }
            return HomePage();
          },
          error: (error, stackTrace) => Center(
            child: Text("Somthing Went Wrong"),
          ),
          loading: () => CircularProgressIndicator(),
        );
  }
}
