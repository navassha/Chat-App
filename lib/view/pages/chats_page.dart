import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/widgets/modified_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(context.width(10)),
        child: Column(
          children: [
            _searchBar(context),
            Gap(
              context.width(20),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: context.width(90),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width(10)),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: context.width(35),
                      backgroundColor: Colors.teal,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          context.width(50),
                        ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        const StyledText(
                          text: "Navas Shareef",
                          size: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        Gap(context.width(5)),
                        SizedBox(
                          width: context.width(200),
                          child: const StyledText(
                            text: "Hello Monoose Enthuva Paad",
                            size: 16,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        const Spacer(),
                        const StyledText(text: "7:08 PM", size: 13),
                        Gap(context.width(5)),
                        CircleAvatar(
                          radius: context.width(10),
                          child: const Center(
                            child: StyledText(
                              text: "1",
                              size: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.width(20),
                        ),
                        const Spacer(),
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

Container _searchBar(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: context.width(60),
    decoration: BoxDecoration(
      color: const Color(0x5FC7C7C7),
      borderRadius: BorderRadius.circular(
        context.width(15),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width(5),
      ),
      child: Center(
        child: TextField(
          cursorColor: Colors.black,
          cursorWidth: context.width(3),
          cursorHeight: context.width(16),
          cursorRadius: const Radius.elliptical(10, 10),
          style: TextStyle(
            fontSize: context.width(19),
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: "Search or Start New Chat",
            hintStyle: TextStyle(
              fontSize: context.width(18),
            ),
            contentPadding: EdgeInsets.all(context.width(20)),
            focusedBorder:
                const UnderlineInputBorder(borderSide: BorderSide.none),
            enabledBorder:
                const UnderlineInputBorder(borderSide: BorderSide.none),
            prefixIcon: Icon(
              CupertinoIcons.search,
              color: Colors.black,
              size: context.width(26),
            ),
          ),
        ),
      ),
    ),
  );
}
