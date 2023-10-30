import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/view/authentication/authpage_view.dart';
import 'package:chat_app/widgets/modified_text.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(context.width(10)),
        child: Column(
          children: [
            SizedBox(
              height: context.width(105),
            ),
            Center(
              child: SizedBox(
                height: context.width(255),
                width: context.width(253),
                child: Image.asset(
                  "assets/images/Group 6.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: context.width(57),
            ),
            SizedBox(
              height: context.width(140),
              width: context.width(396),
              child: Image.asset(
                "assets/images/Chat With Your favourite persons Without Limits And Love!.png",
              ),
            ),
            SizedBox(
              height: context.width(193),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const AuthPageView(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              borderRadius: BorderRadius.circular(
                context.width(22),
              ),
              child: Container(
                width: context.width(270),
                height: context.width(58),
                decoration: BoxDecoration(
                  color: const Color(0xff5A25FA),
                  borderRadius: BorderRadius.circular(
                    context.width(22),
                  ),
                ),
                child: const Center(
                  child: StyledText(
                    text: "Start Messaging",
                    size: 21,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
