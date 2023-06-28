import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nacos_eboard/components/delegatedText.dart';
import 'package:nacos_eboard/routes/routes.dart';
import 'package:nacos_eboard/services/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.secondaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DelegatedText(
                      text: "Notice",
                      fontSize: 28,
                      fontName: "Main",
                      color: Constants.primaryColor,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => Get.toNamed(Routes.profile),
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 228, 236, 230),
                        minRadius: 25,
                        maxRadius: 25,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/person.png",
                            width: 50,
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                DelegatedText(
                  fontSize: 17,
                  text: '23 Notifications',
                  color: Constants.tertiaryColor,
                  fontName: 'Main',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    height: size.height * .8,
                    width: size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: List.generate(
                              20,
                              (index) => InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.notice);
                                },
                                child: Container(
                                  width: size.width * .43,
                                  height: size.height * .2,
                                  decoration: const BoxDecoration(
                                    color: Constants.basicColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(221, 207, 203, 203),
                                        blurRadius: 1,
                                        offset: Offset(1, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DelegatedText(
                                          fontSize: 15,
                                          text: '23 June, 2023',
                                          color: Constants.tertiaryColor,
                                          truncate: true,
                                          fontName: 'Main',
                                        ),
                                        DelegatedText(
                                          fontSize: 15,
                                          text: 'TUESDAY MEETING!!',
                                          color: Constants.primaryColor,
                                          truncate: true,
                                          fontName: 'Main',
                                        ),
                                        const SizedBox(height: 4),
                                        DelegatedText(
                                          fontSize: 16,
                                          overflow: true,
                                          text:
                                              'All the staff presence is required at the hall of meeting as soon as possible because',
                                          color: Constants.tertiaryColor,
                                          truncate: false,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
