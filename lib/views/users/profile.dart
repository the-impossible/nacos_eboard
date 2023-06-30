import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nacos_eboard/components/delegatedForm.dart';
import 'package:nacos_eboard/components/delegatedText.dart';
import 'package:nacos_eboard/controllers/profile_controller.dart';
import 'package:nacos_eboard/controllers/updateProfile_controller.dart';
import 'package:nacos_eboard/routes/routes.dart';
import 'package:nacos_eboard/services/constants.dart';
import 'package:nacos_eboard/utils/formValidation.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UpdateProfileController updateProfileController =
      Get.put(UpdateProfileController());
  ProfileController profileController = Get.put(ProfileController());

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    updateProfileController.nameController.text =
        profileController.userProfile!.name;
    updateProfileController.usernameController.text =
        profileController.userProfile!.username;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.secondaryColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Constants.tertiaryColor,
          title: DelegatedText(
            fontSize: 20,
            text: 'Update Profile',
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * .25,
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
                              "assets/approve.png",
                              width: 130,
                              height: 120,
                            ),
                            DelegatedText(
                              fontSize: 20,
                              text: updateProfileController.nameController.text,
                              color: Constants.tertiaryColor,
                              fontName: 'Main',
                            ),
                            DelegatedText(
                              fontSize: 20,
                              text: updateProfileController
                                  .usernameController.text,
                              color: Constants.tertiaryColor,
                              fontName: 'Main',
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
                        text: 'Fill to update your account information',
                        color: Constants.tertiaryColor,
                        fontName: 'Sub',
                      ),
                    ),
                    delegatedForm(
                      fieldName: 'Username',
                      icon: Icons.person_off_rounded,
                      hintText: 'Enter a Username',
                      isSecured: false,
                      validator: FormValidation.validateUsername,
                      formController:
                          updateProfileController.usernameController,
                    ),
                    delegatedForm(
                      fieldName: 'Full Name',
                      icon: Icons.person,
                      hintText: 'Enter your full name',
                      isSecured: false,
                      validator: FormValidation.validateName,
                      formController: updateProfileController.nameController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              fontFamily: 'Main',
                              color: Constants.tertiaryColor,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.changePassword),
                          child: const Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              fontFamily: 'Main',
                              color: Constants.tertiaryColor,
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
                            if (_formKey.currentState!.validate()) {
                              updateProfileController.userId =
                                  profileController.userProfile!.userId;
                              updateProfileController.isLec =
                                  profileController.userProfile!.isLec;
                              updateProfileController.verifyUpdateAccount();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Constants.tertiaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: DelegatedText(
                            fontSize: 15,
                            text: 'Update Profile',
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
      ),
    );
  }
}
