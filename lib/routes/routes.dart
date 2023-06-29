import 'package:get/get.dart';
import 'package:nacos_eboard/views/auth/signIn.dart';
import 'package:nacos_eboard/views/auth/signUp.dart';
import 'package:nacos_eboard/views/splash_screen.dart';
import 'package:nacos_eboard/views/users/change_password.dart';
import 'package:nacos_eboard/views/users/home.dart';
import 'package:nacos_eboard/views/users/notice.dart';
import 'package:nacos_eboard/views/users/profile.dart';

class Routes {
  static String splash = '/';
  static String signUp = '/signUp';
  static String signIn = '/signIn';
  static String home = '/home';
  static String notice = '/notice';
  static String profile = '/profile';
  static String changePassword = '/changePassword';
}

final getPages = [
  GetPage(
    name: Routes.splash,
    page: () => const Splash(),
  ),
  GetPage(
    name: Routes.signUp,
    page: () => const SignUp(),
  ),
  GetPage(
    name: Routes.signIn,
    page: () => const SignIn(),
  ),
  GetPage(
    name: Routes.home,
    page: () => const Home(),
  ),
  GetPage(
    name: Routes.notice,
    page: () => const Notice(),
  ),
  GetPage(
    name: Routes.profile,
    page: () => const Profile(),
  ),
  GetPage(
    name: Routes.changePassword,
    page: () => const Password(),
  ),
];
