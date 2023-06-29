import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nacos_eboard/components/delegatedForm.dart';
import 'package:nacos_eboard/components/delegatedText.dart';
import 'package:nacos_eboard/controllers/register_controller.dart';
import 'package:nacos_eboard/routes/routes.dart';
import 'package:nacos_eboard/services/constants.dart';
import 'package:nacos_eboard/utils/formValidation.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  RegisterController registerController = Get.put(RegisterController());

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
                        delegatedForm(
                          fieldName: 'Username',
                          icon: Icons.person,
                          hintText: 'Username',
                          isSecured: false,
                          validator: FormValidation.validateUsername,
                          formController: registerController.usernameController,
                        ),
                        delegatedForm(
                          fieldName: 'Full name',
                          icon: Icons.person,
                          hintText: 'Enter your Full name',
                          isSecured: false,
                          validator: FormValidation.validateName,
                          formController: registerController.nameController,
                        ),
                        delegatedForm(
                          fieldName: 'Password',
                          icon: Icons.lock,
                          hintText: 'Enter your password',
                          isSecured: true,
                          validator: FormValidation.validatePassword,
                          formController: registerController.passwordController,
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
                                  registerController.verifyCreateAccount();
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
