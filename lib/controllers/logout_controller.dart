import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nacos_eboard/components/delegatedSnackBar.dart';
import 'package:nacos_eboard/controllers/tokenController.dart';
import 'package:nacos_eboard/routes/routes.dart';
import 'package:nacos_eboard/utils/endpoints.dart';
import 'package:nacos_eboard/utils/loading.dart';

class LogoutController extends GetxController {
  verifyLogin() async {
    Get.showOverlay(
        asyncFunction: () => signOut(), loadingWidget: const Loading());
  }

  Future<void> signOut() async {
    TokenController tokenController = Get.put(TokenController());

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenController.token!.access}'
      };

      var url =
          Uri.parse(APIEndPoints.baseURL + APIEndPoints.authEndPoints.signOut);

      var request = http.MultipartRequest('POST', url);

      request.headers.addAll(headers);

      request.fields.addAll(
        {'refresh': tokenController.token!.refresh},
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Get.offNamedUntil(Routes.signIn, (route) => false);

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
