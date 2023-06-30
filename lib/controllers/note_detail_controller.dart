import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nacos_eboard/components/delegatedSnackBar.dart';
import 'package:nacos_eboard/controllers/tokenController.dart';
import 'package:nacos_eboard/models/notice_detail.dart';
import 'package:nacos_eboard/routes/routes.dart';
import 'package:nacos_eboard/utils/endpoints.dart';
import 'package:nacos_eboard/utils/loading.dart';

class NoteDetailController extends GetxController {
  NoticeDetail? noticeDetail;
  String? noteID;

  processGetNotice() async {
    Get.showOverlay(
        asyncFunction: () => getNoticeDetails(),
        loadingWidget: const Loading());
  }

  Future<void> getNoticeDetails() async {
    TokenController tokenController = Get.put(TokenController());
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenController.token!.access}'
      };

      var url = Uri.parse(
          APIEndPoints.baseURL + APIEndPoints.authEndPoints.getNotice + noteID!);

      var request = http.MultipartRequest('GET', url);

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {

        noticeDetail = noticeDetailFromJson(await response.stream.bytesToString());
        Get.toNamed(Routes.notice);

      } else {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("Error: ", false));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Error: ${e.toString()}", false));
    }
  }
}
