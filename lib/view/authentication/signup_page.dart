import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/model/authentication.dart';
import 'package:chat_app/providers/authentication.dart';
import 'package:chat_app/providers/password_provider.dart';
import 'package:chat_app/widgets/click_container.dart';
import 'package:chat_app/widgets/google_container.dart';
import 'package:chat_app/widgets/loginpage_local.dart';
import 'package:chat_app/widgets/modified_text.dart';
import 'package:chat_app/widgets/mytextfiled.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerWidget {
  SignupPage({super.key});
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final address = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showpassword = ref.watch(showSignUpPassword);
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
                    "assets/images/“Hey buddy Create Your Account Here 🤩”.png",
                  ),
                ),
                SizedBox(
                  height: context.width(7),
                ),
                const StyledText(
                  text: "Fill The Columns And continue",
                  size: 22,
                  fontWeight: FontWeight.w600,
                ),
                _textfieldColums(context, ref),
                //we are adding a row for show password and forgot password and changed into a widget for cleaner code

                _showPassword(context, ref, showpassword),
                SizedBox(
                  height: context.width(34),
                ),

                // if user don't have an account sign up here

                const SignUpPageNavigator(
                  text: 'Scroll Right',
                  longText: 'Already Have a Acoount?',
                ),

                //Here is the login button click and getting userdetails and storing to firebase
                SizedBox(
                  height: context.width(47),
                ),
                InkWell(
                  onTap: () async {
                    if (email.text.isEmpty && password.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.black,
                          content: Text(
                            "Fill The Main Columns",
                          ),
                        ),
                      );
                    } else {
                      try {
                        await AuthServices.createUser(
                            email.text, password.text);

                        ref.read(userNameProvider.notifier).state = name.text;
                        ref.read(userAdressProvider.notifier).state =
                            address.text;
                        ref.read(userEmailAdress.notifier).state = email.text;
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
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
                        }
                      }
                    }
                  },
                  child: const ClickContainer(
                    text: 'Sign Up',
                  ),
                ),
                SizedBox(
                  height: context.width(47),
                ),

                //Here is the option for login with google Accounts and

                const GoogleLogorSign(
                  text: 'Sign in With Google',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _textfieldColums(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          height: context.width(40),
        ),
        // this textfield for user name and user address getting
        MyTextfield(
          controller: name,
          hintText: "Enter Your Name",
        ),
        SizedBox(
          height: context.width(37),
        ),

        MyTextfield(
          controller: address,
          hintText: "Enter Your Address",
        ),
        SizedBox(
          height: context.width(37),
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
          obscureText: ref.watch(showSignUpPassword) == false ? true : false,
        ),
        SizedBox(
          height: context.width(30),
        ),
      ],
    );
  }

  Row _showPassword(BuildContext context, WidgetRef ref, bool showpassword) {
    return Row(
      children: [
        SizedBox(
          width: context.width(26),
        ),
        IconButton(
          onPressed: () {
            ref.read(showSignUpPassword.notifier).state = !showpassword;
          },
          icon: ref.watch(showSignUpPassword) == false
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
      ],
    );
  }
}
