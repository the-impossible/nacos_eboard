// import 'dart:convert';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nacos_eboard/components/delegatedSnackBar.dart';
import 'package:nacos_eboard/routes/routes.dart';
import 'package:nacos_eboard/utils/endpoints.dart';
import 'package:nacos_eboard/utils/loading.dart';

class RegisterController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  verifyCreateAccount() async {
    Get.showOverlay(
        asyncFunction: () => createAccount(), loadingWidget: const Loading());
  }

  Future<void> createAccount() async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse(APIEndPoints.baseURL + APIEndPoints.authEndPoints.signUp));

      request.fields.addAll({
        'username': usernameController.text.toLowerCase(),
        'name': nameController.text,
        'is_lec': 'false',
        'password': passwordController.text,
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        usernameController.clear();
        nameController.clear();
        passwordController.clear();

        ScaffoldMessenger.of(Get.context!).showSnackBar(
            delegatedSnackBar("Account created successfully!", true));
        Get.offNamed(Routes.signIn);
      } else {
        String output = "";
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = json.decode(responseBody);
        jsonResponse.forEach((key, value) {
          if (value is List) {
            List<dynamic> valueList = value;
            if (valueList.isNotEmpty) {
              String cleanValue = valueList[0]
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '');
              output += "$cleanValue\n";
            }
          }
        });
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("Error: $output", false));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Error: ${e.toString()}", false));
    }
  }
}
