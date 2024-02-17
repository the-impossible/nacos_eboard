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

  static String? vPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is Required!';
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

  static String? vUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is Required!';
    }
    return null;
  }

    static String? validatePhone(String? value) {
    bool phoneValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value!);
    if (value.isEmpty) {
      return 'Phone number is Required!';
    } else if (!phoneValid) {
      return 'Valid Phone number is Required!';
    }
    return null;
  }
  
}
