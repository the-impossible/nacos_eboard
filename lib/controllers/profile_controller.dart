import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nacos_eboard/components/delegatedSnackBar.dart';
import 'package:nacos_eboard/controllers/tokenController.dart';
import 'package:nacos_eboard/models/user_profile.dart';
import 'package:nacos_eboard/routes/routes.dart';
import 'package:nacos_eboard/utils/endpoints.dart';
import 'package:nacos_eboard/utils/loading.dart';

class ProfileController extends GetxController {
  UserProfile? userProfile;

  @override
  void onInit() {
    super.onInit();
    Get.showOverlay(
        asyncFunction: () => getProfile(), loadingWidget: const Loading());
  }

  var isLoading = false.obs;

  Future<void> getProfile() async {
    TokenController tokenController = Get.put(TokenController());

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenController.token!.access}'
      };

      var url =
          Uri.parse(APIEndPoints.baseURL + APIEndPoints.authEndPoints.profile);

      var request = http.MultipartRequest('GET', url);

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();


      if (response.statusCode == 200) {
        userProfile =
            userProfileFromJson(await response.stream.bytesToString());
        isLoading(true);
        // route to home page
        Get.offNamed(Routes.home);
      } else {
        ScaffoldMessenger.of(Get.context!)
            .showSnackBar(delegatedSnackBar("Error: ", false));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(delegatedSnackBar("Error: ${e.toString()}", false));
    } finally {
      isLoading(false);
    }
  }
}
