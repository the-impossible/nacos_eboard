import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nacos_eboard/components/delegatedForm.dart';
import 'package:nacos_eboard/components/delegatedText.dart';
import 'package:nacos_eboard/routes/routes.dart';
import 'package:nacos_eboard/services/constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Constants.primaryColor,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 5),
                    child: Image.asset(
                      "assets/logo.png",
                      width: 150,
                      height: 130,
                    ),
                  ),
                  DelegatedText(
                    fontSize: 28,
                    text: 'e-Notice Board',
                    color: Constants.tertiaryColor,
                    truncate: false,
                    fontName: 'Main',
                  ),
                  const SizedBox(height: 20),
                  const delegatedForm(
                    fieldName: 'Username',
                    icon: Icons.person,
                    hintText: 'Enter your File or Reg number',
                    isSecured: false,
                  ),
                  const delegatedForm(
                    fieldName: 'Password',
                    icon: Icons.lock,
                    hintText: 'Enter your password',
                    isSecured: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Don't have a student account?",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SFPReg',
                          color: Constants.tertiaryColor,
                          letterSpacing: 1,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed(Routes.signUp),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            fontFamily: 'Main',
                            color: Constants.primaryColor,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.home);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: DelegatedText(
                          fontSize: 15,
                          text: 'Sign In',
                          color: Constants.basicColor,
                          fontName: 'Main',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
