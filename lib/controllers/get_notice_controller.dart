import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nacos_eboard/components/delegatedSnackBar.dart';
import 'package:nacos_eboard/controllers/tokenController.dart';
import 'package:nacos_eboard/models/all_notice.dart';
import 'package:nacos_eboard/utils/endpoints.dart';

class GetNoticeController extends GetxController {
  List<AllNotice>? allNotice;

  Future<List<AllNotice>?> getAllNotice() async {
    TokenController tokenController = Get.put(TokenController());

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenController.token!.access}'
      };

      var url = Uri.parse(
          APIEndPoints.baseURL + APIEndPoints.authEndPoints.allNotice);

      var request = http.MultipartRequest('GET', url);

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        allNotice = allNoticeFromJson(await response.stream.bytesToString());

        if (allNotice!.isEmpty) {
          ScaffoldMessenger.of(Get.context!)
              .showSnackBar(delegatedSnackBar("No Notice Available", false));
        }
        return allNotice;
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            delegatedSnackBar("Error: ${response.reasonPhrase}", false));
        return [];
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Error: ${e.toString()}", false));
      return [];
    }
  }
}
