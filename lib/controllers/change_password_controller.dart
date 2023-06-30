import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nacos_eboard/components/delegatedSnackBar.dart';
import 'package:nacos_eboard/controllers/tokenController.dart';
import 'package:nacos_eboard/routes/routes.dart';
import 'package:nacos_eboard/utils/endpoints.dart';
import 'package:nacos_eboard/utils/loading.dart';

class ChangePasswordController extends GetxController {
  String? userId;

  TextEditingController password0 = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  processChangePassword() async {
    Get.showOverlay(
        asyncFunction: () => changePassword(), loadingWidget: const Loading());
  }

  Future<void> changePassword() async {
    try {
      TokenController tokenController = Get.put(TokenController());

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenController.token!.access}'
      };

      var url = Uri.parse(APIEndPoints.baseURL +
          APIEndPoints.authEndPoints.changePassword +
          userId!);

      var request = http.MultipartRequest('PUT', url);
      request.fields.addAll({
        'password0': password0.text,
        'password1': password1.text,
        'password2': password2.text,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            delegatedSnackBar("Password Changed! Login again", true));

        Get.offNamedUntil(Routes.signIn, (route) => false);
      } else {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("Invalid form details", false));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("FAILED: $e", false));
    }
  }
}
