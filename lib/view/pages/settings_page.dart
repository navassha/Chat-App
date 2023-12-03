import 'dart:io';
import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/providers/dark_mode.dart';
import 'package:chat_app/widgets/modified_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkmode = ref.watch(darkmodeProvider);
    return Scaffold(
      backgroundColor: darkmode == true ? Colors.black : Colors.white,
      body: Column(
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: ref.watch(selectedImageProvider) == null
                  ? const AssetImage("assets/images/user defoult image.png")
                  : Image.file(File(ref.watch(selectedImageProvider)!.path))
                      .image,
              radius: context.width(90),
              child: Padding(
                padding: EdgeInsets.only(
                  left: context.width(120),
                  top: context.width(120),
                ),
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        elevation: 10,
                        showCloseIcon: true,
                        closeIconColor:
                            darkmode == true ? Colors.white : Colors.black,
                        backgroundColor:
                            darkmode == true ? Colors.black : Colors.white,
                        duration: const Duration(minutes: 3),
                        content: const Scaffoldmssger(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor:
                        darkmode == true ? Colors.black : Colors.white,
                    radius: context.width(20),
                    child: CircleAvatar(
                      radius: context.width(16),
                      backgroundColor:
                          darkmode == true ? Colors.white : Colors.black,
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          size: context.width(20),
                          color: darkmode == true ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Scaffoldmssger extends ConsumerStatefulWidget {
  const Scaffoldmssger({
    super.key,
  });

  @override
  ConsumerState<Scaffoldmssger> createState() => _ScaffoldmssgerState();
}

class _ScaffoldmssgerState extends ConsumerState<Scaffoldmssger> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? pickedImage = await picker.pickImage(
                    source: ImageSource.gallery,
                  );

                  if (pickedImage != null) {
                    ref.read(selectedImageProvider.notifier).state =
                        pickedImage;
                  }
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }
                },
                child: CircleAvatar(
                  radius: context.width(50),
                  backgroundImage: const AssetImage(
                    "assets/images/Photos.jpeg",
                  ),
                ),
              ),
              Gap(context.width(10)),
              const StyledText(
                text: "Gallery",
                size: 18,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
          Gap(context.width(35)),
          Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? pickedImage = await picker.pickImage(
                    source: ImageSource.camera,
                  );

                  if (pickedImage != null) {
                    ref.read(selectedImageProvider.notifier).state =
                        pickedImage;
                  }
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }
                },
                child: CircleAvatar(
                  radius: context.width(50),
                  backgroundImage:
                      const AssetImage("assets/images/Camera.jpeg"),
                ),
              ),
              Gap(context.width(10)),
              const StyledText(
                text: "Camera",
                size: 18,
                fontWeight: FontWeight.w600,
              )
            ],
          ),
        ],
      ),
    );
  }
}

final selectedImageProvider = StateProvider<XFile?>((ref) => null);
