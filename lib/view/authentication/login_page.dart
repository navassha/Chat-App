import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/model/authentication.dart';
import 'package:chat_app/providers/password_provider.dart';
import 'package:chat_app/widgets/click_container.dart';
import 'package:chat_app/widgets/google_container.dart';
import 'package:chat_app/widgets/loginpage_local.dart';
import 'package:chat_app/widgets/modified_text.dart';
import 'package:chat_app/widgets/mytextfiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showpassword = ref.watch(showPassWordProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xffF7F6FC),
        body: Padding(
          padding: EdgeInsets.all(context.width(10)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: context.width(41),
                ),
                Center(
                  child: SizedBox(
                    height: context.width(116),
                    width: context.width(142),
                    child: Image.asset(
                      "assets/images/Chat App Logo.jpeg",
                    ),
                  ),
                ),
                SizedBox(
                  height: context.width(20),
                ),
                SizedBox(
                  height: context.width(75),
                  width: context.width(330),
                  child: Image.asset(
                    "assets/images/“Hey Welcome Back Buddy We Missed You A Lot 🥹”.png",
                  ),
                ),
                SizedBox(
                  height: context.width(7),
                ),
                const StyledText(
                  text: "Login to Continue",
                  size: 22,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: context.width(40),
                ),
                // We created a Text Field and turn that textfield into a widget and the textfield used for  Getting Email id For Login

                MyTextfield(
                  controller: email,
                  hintText: "Enter Your Email",
                ),
                SizedBox(
                  height: context.width(37),
                ),
                // we adding one more contmized textfield there adding for getting password from user

                MyTextfield(
                  hintText: "Enter Your Password",
                  controller: password,
                  obscureText:
                      ref.watch(showPassWordProvider) == false ? true : false,
                ),
                SizedBox(
                  height: context.width(30),
                ),
                //we are adding a row for show password and forgot password and changed into a widget for cleaner code

                ShowpassRow(showpassword: showpassword),
                SizedBox(
                  height: context.width(34),
                ),

                // if user don't have an account sign up here

                const SignUpPageNavigator(
                  text: 'Scroll Left',
                  longText: "Don't Have a Account?",
                ),

                //Here is the login button click and getting userdetails and storing to firebase
                SizedBox(
                  height: context.width(47),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(context.width(22)),
                  onTap: () async {
                    if (email.text.isEmpty && password.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: StyledText(
                            text: 'Fill The Madotory Fields',
                            size: 16,
                          ),
                        ),
                      );
                    } else {
                      try {
                        await AuthServices.userLogin(email.text, password.text);
                      } on FirebaseException catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: e.code == "INVALID_LOGIN_CREDENTIALS"
                                  ? const StyledText(
                                      text: "Check The Deatils!🍀",
                                      size: 16,
                                    )
                                  : StyledText(
                                      text: e.message.toString(),
                                      size: 16,
                                    ),
                            ),
                          );
                          print(e.message);
                        }
                      }
                    }
                  },
                  child: const ClickContainer(
                    text: 'Login',
                  ),
                ),
                SizedBox(
                  height: context.width(47),
                ),

                //Here is the option for login with google Accounts and

                const GoogleLogorSign(
                  text: 'Login With Google',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
