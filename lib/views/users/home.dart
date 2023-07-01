import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nacos_eboard/components/delegatedText.dart';
import 'package:nacos_eboard/controllers/get_notice_controller.dart';
import 'package:nacos_eboard/controllers/note_detail_controller.dart';
import 'package:nacos_eboard/models/all_notice.dart';
import 'package:nacos_eboard/routes/routes.dart';
import 'package:nacos_eboard/services/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GetNoticeController getNoticeController = Get.put(GetNoticeController());
  NoteDetailController noteDetailController = Get.put(NoteDetailController());
  DateTime timeBackPressed = DateTime.now();

  Future<List<AllNotice>?>? allNotice;

  Future<List<AllNotice>?> getNotice() async {
    setState(() {
      allNotice = getNoticeController.getAllNotice();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= const Duration(seconds: 2);
          timeBackPressed = DateTime.now();

          if (isExitWarning) {
            const message = 'Press back again to exit';
            Fluttertoast.showToast(
              msg: message,
              fontSize: 18,
              backgroundColor: Constants.primaryColor,
            );
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: Constants.secondaryColor,
          body: RefreshIndicator(
            onRefresh: () => getNotice(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                            backgroundColor:
                                const Color.fromARGB(255, 228, 236, 230),
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
                    SizedBox(
                      height: size.height * .8,
                      width: size.width,
                      child: SingleChildScrollView(
                        child: FutureBuilder<List<AllNotice>?>(
                            future: (allNotice == null)
                                ? getNoticeController.getAllNotice()
                                : allNotice,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // While the future is loading
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                // If an error occurred
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * .5 / 2.5),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/error.png",
                                          width: 200,
                                          height: 200,
                                        ),
                                        DelegatedText(
                                          text: '${snapshot.error}',
                                          fontSize: 25,
                                          color: Constants.tertiaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                List<AllNotice> allNotice = snapshot.data!;
                                // If the data is available
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: DelegatedText(
                                        fontSize: 17,
                                        text:
                                            '${allNotice.length} Notification',
                                        color: Constants.tertiaryColor,
                                        fontName: 'Main',
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 20,
                                      runSpacing: 20,
                                      children: List.generate(
                                        allNotice.length,
                                        (index) {
                                          final noticeData = allNotice[index];
                                          return InkWell(
                                            onTap: () {
                                              noteDetailController.noteID =
                                                  noticeData.id;
                                              noteDetailController
                                                  .processGetNotice();
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
                                                    color: Color.fromARGB(
                                                        221, 207, 203, 203),
                                                    blurRadius: 1,
                                                    offset: Offset(1, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    DelegatedText(
                                                      fontSize: 15,
                                                      text: noticeData
                                                          .dateCreated,
                                                      color: Constants
                                                          .tertiaryColor,
                                                      truncate: true,
                                                      fontName: 'Main',
                                                    ),
                                                    DelegatedText(
                                                      fontSize: 15,
                                                      text: noticeData.title,
                                                      color: Constants
                                                          .primaryColor,
                                                      truncate: true,
                                                      fontName: 'Main',
                                                    ),
                                                    const SizedBox(height: 4),
                                                    DelegatedText(
                                                      fontSize: 16,
                                                      overflow: true,
                                                      text: noticeData
                                                          .description
                                                          .toLowerCase(),
                                                      color: Constants
                                                          .tertiaryColor,
                                                      truncate: false,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                // If there is no data available
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * .5 / 2.5),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/notice.png",
                                          width: 200,
                                          height: 200,
                                        ),
                                        DelegatedText(
                                          text: 'No notice available',
                                          fontSize: 25,
                                          color: Constants.tertiaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }),
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
