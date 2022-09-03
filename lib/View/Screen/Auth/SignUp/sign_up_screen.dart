// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/Util/Assets/assets.dart';
import 'package:insta/Util/Widgets/Auth/custom_text_form_field.dart';
import 'package:insta/Util/Widgets/Auth/instagram_pic_widget.dart';
import 'package:insta/Util/Widgets/Auth/log_up_button.dart';
import 'package:insta/Util/utils.dart';
import 'package:insta/View/Screen/Auth/Login/login_screen.dart';
import 'package:insta/resources/auth_methods.dart';

import '../../../../Util/Widgets/Auth/sizebox_between_field.dart';
import '../../../../Util/Widgets/LayOut/global_variables.dart';
import '../../../../Util/Widgets/LayOut/mobile_screen_layout.dart';
import '../../../../Util/Widgets/LayOut/responsive_layout_.dart';
import '../../../../Util/Widgets/LayOut/web_screen_lauout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  bool hiddenPassword = true;
  bool isLoading = false;
  Uint8List? image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    userController.dispose();
    emailController.dispose();
    passWordController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: emailController.text,
      password: passWordController.text,
      username: userController.text,
      bio: bioController.text,
      file: image!,
    );
    if (kDebugMode) {
      print(res);
    }
    setState(() {
      isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayOut(
            mobileScreenLayOut: MobileScreenLayOut(),
            webScreenLayOut: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigateToAnotherScreen() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (_) {
        return const LoginScreen();
      },
    ), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding:  MediaQuery.of(context).size.width > webScreenSize  ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3,
                )
              : const EdgeInsets.symmetric(horizontal: 32),
          // const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              const InstagramPictureWidget(),
              const SizedBox(
                height: 64,
              ),
              // circular widget to accept and show our selected file
              Stack(
                children: [
                  image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: AssetImage(Assets.DefaultPic),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 60,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  )
                ],
              ),
              const SizeBetField(),
              CustomTextFormField(
                hintText: 'Enter your username',
                textInputType: TextInputType.name,
                controller: userController,
                icon: const Icon(
                  Icons.person,
                ),
              ),
              const SizeBetField(),
              CustomTextFormField(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                controller: emailController,
                icon: const Icon(
                  Icons.email,
                ),
              ),
              const SizeBetField(),
              CustomTextFormField(
                hintText: 'Enter your PassWord',
                icon: const Icon(Icons.lock),
                textInputType: TextInputType.number,
                isPass: hiddenPassword,
                controller: passWordController,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      hiddenPassword = !hiddenPassword;
                    });
                  },
                  child: Icon(
                    hiddenPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              const SizeBetField(),
              CustomTextFormField(
                hintText: 'Enter your bio',
                controller: bioController,
                textInputType: TextInputType.text,
              ),
              const SizeBetField(),
              InkWell(
                onTap: signUpUser,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const LogUpButton(
                        text: 'Signup',
                      ),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    child: const Text(
                      "Already have an Account ",
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToAnotherScreen,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text(
                        "Log in",
                      ),
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
