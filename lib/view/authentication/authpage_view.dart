import 'package:chat_app/providers/auth_page_view.dart';
import 'package:chat_app/view/authentication/login_page.dart';
import 'package:chat_app/view/authentication/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPageView extends ConsumerWidget {
  const AuthPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: PageView(
        controller: ref.watch(pageControllerProvider),
        physics: BouncingScrollPhysics(),
        children: [LoginPage(), SignupPage()],
      ),
    );
  }
}
