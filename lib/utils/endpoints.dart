class APIEndPoints {
  static const String baseURL = 'http://172.20.10.3:8000/';
  static const String fileURL = 'http://172.20.10.3:8000';
  static final AuthEndPoints authEndPoints = AuthEndPoints();
}

class AuthEndPoints {
  final String signIn = 'auth/login/';
  final String signOut = 'auth/logout/';
  final String signUp = 'auth/register/';
  final String profile = 'auth/getUser/';
  final String allNotice = 'auth/allNotice/';
  final String getNotice = 'auth/getNotice/';
  final String updateProfile = 'auth/updateProfile/';
  final String changePassword = 'auth/changePassword/';
}
