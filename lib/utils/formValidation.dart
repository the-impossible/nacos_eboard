class FormValidation {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is Required!';
    }
    if (value.length < 6) {
      return 'Password should be at least 6 characters!';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is Required!';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is Required!';
    }
    if (value.length < 6) {
      return 'Username should be at least 6 characters!';
    }
    return null;
  }
}
