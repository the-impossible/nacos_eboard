import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nacos_eboard/components/delegatedForm.dart';
import 'package:nacos_eboard/components/delegatedText.dart';
import 'package:nacos_eboard/routes/routes.dart';
import 'package:nacos_eboard/services/constants.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  // LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.secondaryColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Constants.tertiaryColor,
          title: DelegatedText(
            fontSize: 20,
            text: 'Change Password',
            color: Constants.basicColor,
            fontName: 'Main',
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * .17,
                    decoration: const BoxDecoration(
                      color: Constants.basicColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(221, 207, 203, 203),
                          blurRadius: 1,
                          offset: Offset(1, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/password.png",
                            width: 150,
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: DelegatedText(
                      fontSize: 18,
                      align: TextAlign.center,
                      text: 'Fill the form below to change password',
                      color: Constants.tertiaryColor,
                      fontName: 'Sub',
                    ),
                  ),
                  const delegatedForm(
                    fieldName: 'Password',
                    icon: Icons.password,
                    hintText: 'Enter Current Password',
                    isSecured: true,
                  ),
                  const delegatedForm(
                    fieldName: 'New Password',
                    icon: Icons.password,
                    hintText: 'Enter New Password',
                    isSecured: true,
                  ),
                  const delegatedForm(
                    fieldName: 'Confirm Password',
                    icon: Icons.password,
                    hintText: 'Confirm New Password',
                    isSecured: true,
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
                          backgroundColor: Constants.tertiaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: DelegatedText(
                          fontSize: 15,
                          text: 'Change Password',
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
