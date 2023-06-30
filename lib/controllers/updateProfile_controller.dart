import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nacos_eboard/components/delegatedSnackBar.dart';
import 'package:nacos_eboard/controllers/tokenController.dart';
import 'package:nacos_eboard/utils/endpoints.dart';
import 'package:nacos_eboard/utils/loading.dart';

import 'profile_controller.dart';

class UpdateProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  String? userId;
  bool? isLec;

  verifyUpdateAccount() async {
    Get.showOverlay(
        asyncFunction: () => updateAccount(), loadingWidget: const Loading());
  }

  Future<void> updateAccount() async {
    TokenController tokenController = Get.put(TokenController());

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenController.token!.access}'
      };

      var url = Uri.parse(APIEndPoints.baseURL +
          APIEndPoints.authEndPoints.updateProfile +
          userId!);

      var request = http.MultipartRequest('PUT', url);

      request.fields.addAll({
        'name': nameController.text,
        'username': usernameController.text,
        'is_lec': isLec.toString(),
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            delegatedSnackBar("Profile Updated Successfully", true));

        ProfileController profileController = Get.put(ProfileController());
        profileController.getProfile();

      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            delegatedSnackBar(response.reasonPhrase.toString(), false));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("FAILED: $e", false));
    }
  }
}
