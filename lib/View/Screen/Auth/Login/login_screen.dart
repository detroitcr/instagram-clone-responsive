// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta/Util/Widgets/Auth/custom_text_form_field.dart';
import 'package:insta/Util/Widgets/Auth/sizebox_between_field.dart';
import 'package:insta/Util/Widgets/LayOut/global_variables.dart';
import 'package:insta/Util/Widgets/LayOut/web_screen_lauout.dart';
import 'package:insta/Util/utils.dart';
import 'package:insta/View/Screen/Auth/SignUp/sign_up_screen.dart';
import 'package:insta/resources/auth_methods.dart';

import '../../../../Util/Widgets/Auth/instagram_pic_widget.dart';
import '../../../../Util/Widgets/Auth/log_up_button.dart';
import '../../../../Util/Widgets/LayOut/mobile_screen_layout.dart';
import '../../../../Util/Widgets/LayOut/responsive_layout_.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  bool _isLoading = false;
  bool isHiddenPassWord = true;

  // void hiddenPassWord() {

  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passWordController.dispose();
    super.dispose();
  }

  void login() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: emailController.text, password: passWordController.text);
    if (kDebugMode) {
      print('success');
    }

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayOut(
            mobileScreenLayOut: MobileScreenLayOut(),
            webScreenLayOut: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToAnotherScreen() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (_) {
        return const SignUpScreen();
      },
    ), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3,
                )
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              const InstagramPictureWidget(),
              const SizedBox(
                height: 64,
              ),
              CustomTextFormField(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                controller: emailController,
                icon: const Icon(
                  Icons.email,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hintText: 'Enter your PassWord',
                textInputType: TextInputType.phone,
                controller: passWordController,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isHiddenPassWord = !isHiddenPassWord;
                    });
                  },
                  child: Icon(
                    isHiddenPassWord ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                icon: const Icon(
                  Icons.lock,
                ),
                isPass: isHiddenPassWord,
              ),
              const SizeBetField(),
              //button login
              InkWell(
                onTap: login,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const LogUpButton(
                        text: 'Log in',
                      ),
              ),
              const SizedBox(
                height: 12,
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
                      "Don't have an account? ",
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToAnotherScreen,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text(
                        "Sign up",
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
