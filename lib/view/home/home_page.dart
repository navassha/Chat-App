import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/providers/settings_show.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        ref.read(settingsProvider.notifier).state = false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Row(
            children: [
              Text(
                "Chats",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: context.width(28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  ref.read(settingsProvider.notifier).state = !settings;
                },
                icon: const Icon(Icons.more_horiz),
                color: Colors.black,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            //this container is used to do a bottom navigation bar
            _bottomNavigationContainer(context),

            Positioned(
              top: context.width(10),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: context.width(690),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      context.width(50),
                    ),
                    bottomRight: Radius.circular(
                      context.width(50),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.width(10)),
                  child: Column(
                    children: [
                      // this is container is used to search users
                      _searchBar(context),
                    ],
                  ),
                ),
              ),
            ),
            settings != true
                ? Positioned(
                    left: context.width(10),
                    child: const SizedBox(),
                  )
                : Positioned(
                    left: context.width(160),
                    top: context.width(10),
                    child: Container(
                      height: context.width(300),
                      width: context.width(250),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          context.width(20),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Positioned _bottomNavigationContainer(BuildContext context) {
    return Positioned(
      top: context.width(660),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: context.width(160),
        color: const Color.fromARGB(255, 23, 57, 84),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width(10)),
          child: Column(
            children: [
              Gap(context.width(55)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: context.width(35),
                    backgroundColor: Colors.white,
                    child: Icon(
                      CupertinoIcons.phone,
                      size: context.width(30),
                      color: Colors.black,
                    ),
                  ),
                  CircleAvatar(
                    radius: context.width(35),
                    backgroundColor: Colors.white,
                    child: Icon(
                      CupertinoIcons.ellipses_bubble,
                      size: context.width(30),
                      color: Colors.black,
                    ),
                  ),
                  CircleAvatar(
                    radius: context.width(35),
                    backgroundColor: Colors.white,
                    child: Icon(
                      CupertinoIcons.settings_solid,
                      size: context.width(30),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
}
