import 'dart:developer';
import 'dart:io';
import 'package:chat_app/extensions/responsive.dart';
import 'package:chat_app/model/authentication.dart';
import 'package:chat_app/providers/authentication.dart';
import 'package:chat_app/providers/bottom_navigation.dart';
import 'package:chat_app/providers/dark_mode.dart';
import 'package:chat_app/widgets/modified_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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
      body: Padding(
        padding: EdgeInsets.all(context.width(10)),
        child: Column(
          children: [
            Center(
              child: ProfileCircleAvatar(darkmode: darkmode),
            ),
            Gap(
              context.width(30),
            ),
            SettingsCoulms(
              darkmode: darkmode,
              additionaltext: "This Name is only show not your contacts Only",
              type: "Name",
              maintext: ref.watch(userNameProvider),
              icon: Icon(
                CupertinoIcons.textformat_alt,
                size: context.width(30),
                color: darkmode == true ? Colors.white : Colors.black,
              ),
            ),
            Gap(context.width(40)),
            SettingsCoulms(
              darkmode: darkmode,
              type: "Email Address",
              maintext: ref.watch(userEmailAdress),
              additionaltext:
                  "Once You logined and you cant change the email address",
              icon: Icon(
                CupertinoIcons.mail,
                size: context.width(30),
                color: darkmode == true ? Colors.white : Colors.black,
              ),
            ),
            Gap(context.width(30)),
            Center(
              child: GestureDetector(
                onTap: () {
                  AuthServices.signOut();
                  ref.read(bottomNavigationProvider.notifier).state = 1;
                },
                child: Container(
                  width: context.width(200),
                  height: context.width(60),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 190, 185),
                    borderRadius: BorderRadius.circular(
                      context.width(20),
                    ),
                  ),
                  child: const Center(
                    child: StyledText(
                      text: "SIGN OUT",
                      size: 18,
                      fontWeight: FontWeight.w600,
                    ),
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

class ProfileCircleAvatar extends ConsumerWidget {
  const ProfileCircleAvatar({
    super.key,
    required this.darkmode,
  });

  final bool darkmode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: ref.watch(userimageShowing) == null
          ? const AssetImage("assets/images/user defoult image.png")
          : Image.network(ref.watch(userimageShowing)!).image,
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
                closeIconColor: darkmode == true ? Colors.white : Colors.black,
                backgroundColor: darkmode == true ? Colors.black : Colors.white,
                duration: const Duration(minutes: 3),
                content: const Scaffoldmssger(),
              ),
            );
          },
          child: CircleAvatar(
            backgroundColor: darkmode == true ? Colors.black : Colors.white,
            radius: context.width(20),
            child: CircleAvatar(
              radius: context.width(16),
              backgroundColor: darkmode == true ? Colors.white : Colors.black,
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
    );
  }
}

// this the column is used to edit user name

class SettingsCoulms extends ConsumerWidget {
  const SettingsCoulms({
    super.key,
    required this.darkmode,
    required this.type,
    required this.maintext,
    required this.additionaltext,
    required this.icon,
  });

  final bool darkmode;
  final String type;
  final String maintext;
  final Icon icon;
  final String additionaltext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width(15)),
        child: Row(
          children: [
            icon,
            Gap(context.width(20)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledText(text: type, size: 17),
                StyledText(
                  text: maintext,
                  size: 22,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  width: context.width(330),
                  child: StyledText(
                    text: additionaltext,
                    size: 14,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// this is scaffold messenger is using to take user image
// and adding as profile photo and uploading to user detail
// storing on firebase

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

                  // there is getting image from the user
                  //  and uploading to firebase storage

                  if (pickedImage != null) {
                    ref.read(selectedImageProvider.notifier).state =
                        pickedImage;
                    // this unique id makes every images
                    // readeble and easy taking and  sorting
                    String uniqueid =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    Reference referenceroot = FirebaseStorage.instance.ref();
                    Reference referenceDirimages =
                        referenceroot.child("userImages");

                    Reference referenceImageUpload =
                        referenceDirimages.child(uniqueid);

                    // this try cache is uploading file into
                    // firebase storage this using for error handling easly

                    try {
                      await referenceImageUpload.putFile(
                          File(ref.watch(selectedImageProvider)!.path));
                      ref.read(userimageShowing.notifier).state =
                          await referenceImageUpload.getDownloadURL();
                    } catch (e) {
                      log(e.toString());
                    }
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
                    // this unique id makes every images
                    // readeble and easy taking and  sorting
                    String uniqueid =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    Reference referenceroot = FirebaseStorage.instance.ref();
                    Reference referenceDirimages =
                        referenceroot.child("userImages");

                    Reference referenceImageUpload =
                        referenceDirimages.child(uniqueid);

                    // this try cache is uploading file into
                    // firebase storage this using for error handling easly

                    try {
                      await referenceImageUpload.putFile(
                          File(ref.watch(selectedImageProvider)!.path));
                      ref.read(userimageShowing.notifier).state =
                          await referenceImageUpload.getDownloadURL();
                    } catch (e) {
                      log(e.toString());
                    }
                  }
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//  this is the provider used to take image and uplod to firebase

final selectedImageProvider = StateProvider<XFile?>((ref) => null);

//  this is the provider used to getting image from firebase
// and getting as url and showing into the profile section in UI

final userimageShowing = StateProvider<String?>((ref) => null);
