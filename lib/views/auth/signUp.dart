import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nacos_eboard/components/delegatedForm.dart';
import 'package:nacos_eboard/components/delegatedText.dart';
import 'package:nacos_eboard/routes/routes.dart';
import 'package:nacos_eboard/services/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  Image.asset(
                    "assets/logo.png",
                    width: 150,
                    height: 130,
                  ),
                  DelegatedText(
                    fontSize: 28,
                    text: 'e-Notice Board',
                    color: Constants.tertiaryColor,
                    truncate: false,
                    fontName: 'Main',
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const delegatedForm(
                          fieldName: 'Username',
                          icon: Icons.person,
                          hintText: 'Reg number',
                          isSecured: false,
                        ),
                        const delegatedForm(
                          fieldName: 'Full name',
                          icon: Icons.person,
                          hintText: 'Enter your Full name',
                          isSecured: false,
                        ),
                        const delegatedForm(
                          fieldName: 'Password',
                          icon: Icons.lock,
                          hintText: 'Enter your password',
                          isSecured: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: SizedBox(
                            width: size.width,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // registrationController.createAccount();
                                }
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontFamily: 'Main',
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'SFPReg',
                                color: Constants.tertiaryColor,
                                letterSpacing: 1,
                              ),
                            ),
                            TextButton(
                              onPressed: () => Get.toNamed(Routes.signIn),
                              child: const Text(
                                'Sign In',
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
                      ],
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
