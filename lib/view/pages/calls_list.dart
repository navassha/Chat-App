import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/providers/dark_mode.dart';
import 'package:chat_app/widgets/modified_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class CallsListpage extends ConsumerWidget {
  const CallsListpage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkmode = ref.watch(darkmodeProvider);
    return Scaffold(
      backgroundColor: darkmode == true ? Colors.black : Colors.white,
      body: Padding(
        padding: EdgeInsets.all(context.width(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StyledText(
              text: "Recent",
              size: 18,
              color: darkmode == true ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
            Gap(context.width(10)),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: context.width(70),
              child: Padding(
                padding: EdgeInsets.all(context.width(5)),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: context.width(30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(context.width(50)),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://i.pinimg.com/564x/fb/95/63/fb95636f8a44b33c6314bf02f7a17fc5.jpg",
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1,
                          ),
                          errorWidget: (context, url, error) => IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.xmark_circle),
                          ),
                        ),
                      ),
                    ),
                    Gap(context.width(10)),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyledText(
                          text: "Navas Shareef",
                          size: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        StyledText(
                          text: "navvs.n@gmail.com",
                          size: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        const StyledText(text: "6 : 59 PM", size: 13),
                        Gap(context.width(5)),
                        Icon(
                          CupertinoIcons.phone,
                          size: context.width(30),
                          color: darkmode == true ? Colors.white : Colors.black,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
