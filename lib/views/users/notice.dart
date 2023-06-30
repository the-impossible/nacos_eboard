import 'dart:typed_data';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:nacos_eboard/utils/endpoints.dart';
import 'package:nacos_eboard/components/delegatedSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nacos_eboard/components/delegatedText.dart';
import 'package:nacos_eboard/controllers/note_detail_controller.dart';
import 'package:nacos_eboard/services/constants.dart';

class Notice extends StatefulWidget {
  const Notice({super.key});

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  Future<void> downloadDocument(Uint8List documentData, String fileName) async {
    try {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      await FlutterFileSaver().writeFileAsBytes(
        fileName: fileName,
        bytes: documentData,
      );
      // Show a confirmation message
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Document saved successfully", true));
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Error saving document: $e", false));
    } finally {
      navigator!.pop(Get.context!);
    }
  }

  NoteDetailController noteDetailController = Get.put(NoteDetailController());
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
                  text: noteDetailController.noticeDetail!.dateCreated,
                  color: Constants.tertiaryColor,
                  fontName: 'Sub',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: DelegatedText(
                  fontSize: 23,
                  text: noteDetailController.noticeDetail!.title,
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
                  text: noteDetailController.noticeDetail!.description,
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
                          (noteDetailController.noticeDetail!.img.isNotEmpty)
                              ? GestureDetector(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        content: SizedBox(
                                          height: 400,
                                          width: 500,
                                          child: Image.memory(
                                            noteDetailController
                                                .noticeDetail!.img,
                                            width: 130,
                                            height: 120,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  child: Image.memory(
                                    noteDetailController.noticeDetail!.img,
                                    width: 130,
                                    height: 120,
                                  ),
                                )
                              : Image.asset(
                                  'assets/noImage.png',
                                  width: 130,
                                  height: 120,
                                ),
                          DelegatedText(
                            fontSize: 13,
                            align: TextAlign.justify,
                            text: (noteDetailController
                                    .noticeDetail!.img.isNotEmpty)
                                ? 'Notice image'
                                : 'No Image Attached',
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
                          (noteDetailController.noticeDetail!.docs.isNotEmpty)
                              ? InkWell(
                                  onTap: () async {
                                    Uri uri = Uri.parse(
                                        "${APIEndPoints.fileURL}${noteDetailController.noticeDetail!.file}");
                                    String filePath = uri.pathSegments.last;
                                    await downloadDocument(
                                        noteDetailController.noticeDetail!.docs,
                                        filePath);
                                  },
                                  child: Image.asset(
                                    'assets/file.png',
                                    width: 130,
                                    height: 120,
                                  ),
                                )
                              : Image.asset(
                                  'assets/noFile.png',
                                  width: 130,
                                  height: 120,
                                ),
                          DelegatedText(
                            fontSize: 13,
                            align: TextAlign.justify,
                            text: (noteDetailController
                                    .noticeDetail!.docs.isNotEmpty)
                                ? 'Click to download'
                                : 'No File Attached',
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
