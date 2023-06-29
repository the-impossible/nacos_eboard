// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nacos_eboard/components/delegatedSnackBar.dart';
import 'package:nacos_eboard/controllers/profile_controller.dart';
import 'package:nacos_eboard/controllers/tokenController.dart';
import 'package:nacos_eboard/models/token.dart';
import 'package:nacos_eboard/utils/endpoints.dart';
import 'package:nacos_eboard/utils/loading.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  verifyLogin() async {
    Get.showOverlay(
        asyncFunction: () => signIn(), loadingWidget: const Loading());
  }

  Future<void> signIn() async {
    TokenController tokenController = Get.put(TokenController());

    try {
      var request = http.MultipartRequest('POST',
          Uri.parse(APIEndPoints.baseURL + APIEndPoints.authEndPoints.signIn));

      request.fields.addAll({
        'username': usernameController.text.toLowerCase(),
        'password': passwordController.text
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        tokenController.token =
            tokenFromJson(await response.stream.bytesToString());

        ProfileController profileController = Get.put(ProfileController());
        profileController.onInit();
        usernameController.clear();
        passwordController.clear();
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            delegatedSnackBar("Error: ${response.reasonPhrase}", false));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Error: ${e.toString()}", false));
    }
  }
}
