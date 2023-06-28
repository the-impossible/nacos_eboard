import 'package:flutter/material.dart';
import 'package:nacos_eboard/components/delegatedText.dart';
import 'package:nacos_eboard/services/constants.dart';

class Notice extends StatefulWidget {
  const Notice({super.key});

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.secondaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Constants.tertiaryColor,
          title: DelegatedText(
            fontSize: 20,
            text: 'Notification Details',
            color: Constants.basicColor,
            fontName: 'Main',
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: DelegatedText(
                  fontSize: 20,
                  text: '23 June, 2023',
                  color: Constants.tertiaryColor,
                  fontName: 'Sub',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: DelegatedText(
                  fontSize: 23,
                  text: 'How to redesign a 175-year-old Newspaper',
                  color: Constants.primaryColor,
                  fontName: 'Main',
                ),
              ),
              const Divider(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: DelegatedText(
                  fontSize: 18,
                  align: TextAlign.justify,
                  text:
                      'All the staff presence is required at the hall of meeting as soon as possible because' *
                          1,
                  color: Constants.tertiaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: size.width * .43,
                    height: size.height * .24,
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
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/noImage.png",
                            width: 130,
                            height: 120,
                          ),
                          DelegatedText(
                            fontSize: 13,
                            align: TextAlign.justify,
                            text: 'No Image Attached',
                            color: Constants.tertiaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: size.width * .43,
                    height: size.height * .24,
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
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/noFile.png",
                            width: 130,
                            height: 120,
                          ),
                          DelegatedText(
                            fontSize: 13,
                            align: TextAlign.justify,
                            text: 'No File Attached',
                            color: Constants.tertiaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
