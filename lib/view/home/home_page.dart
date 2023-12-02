import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/providers/bottom_navigation.dart';
import 'package:chat_app/providers/settings_show.dart';
import 'package:chat_app/view/pages/calls_list.dart';
import 'package:chat_app/view/pages/chats_page.dart';
import 'package:chat_app/view/pages/settings_page.dart';
import 'package:chat_app/widgets/bottom_nav_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});
  final PageController pageController = PageController(
    initialPage: 1,
    keepPage: false,
  );

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
                ref.watch(bottomNavigationProvider) == 0
                    ? "Calls"
                    : ref.watch(bottomNavigationProvider) == 1
                        ? "Chats"
                        : "Settings",
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
            _bottomNavigationContainer(context, ref),

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
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  child: ref.watch(bottomNavigationProvider) == 0
                      ? const CallsListpage()
                      : ref.watch(bottomNavigationProvider) == 1
                          ? const ChatsPage()
                          : const SettingsPage(),
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

// bottom navigation for the home screen

  Positioned _bottomNavigationContainer(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: context.width(650),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: context.width(170),
        color: const Color.fromARGB(255, 23, 57, 84),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width(10)),
          child: Column(
            children: [
              Gap(context.width(65)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomNavigationForHome(
                    function: () =>
                        ref.read(bottomNavigationProvider.notifier).state = 0,
                    number: 0,
                    icon: Icon(
                      CupertinoIcons.phone,
                      size: context.width(30),
                      color: ref.watch(bottomNavigationProvider) != 0
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  BottomNavigationForHome(
                    function: () =>
                        ref.read(bottomNavigationProvider.notifier).state = 1,
                    icon: Icon(
                      CupertinoIcons.ellipses_bubble,
                      size: context.width(30),
                      color: ref.watch(bottomNavigationProvider) != 1
                          ? Colors.black
                          : Colors.white,
                    ),
                    number: 1,
                  ),
                  BottomNavigationForHome(
                    function: () =>
                        ref.read(bottomNavigationProvider.notifier).state = 2,
                    number: 2,
                    icon: Icon(
                      CupertinoIcons.settings_solid,
                      size: context.width(30),
                      color: ref.watch(bottomNavigationProvider) != 2
                          ? Colors.black
                          : Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
