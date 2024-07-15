mixin IZIValidate {
  ///
  /// check password if return string is has error else null not error.
  ///
  static String? password(String password) {
    if (password.length < 6) return 'Must have at least 6 characters';

    return null;
  }

  ///
  /// Check nullOrEmpty
  ///
  static bool nullOrEmpty(dynamic value) {
    if (value == null ||
        value.toString().trim().isEmpty ||
        value.toString() == 'null' ||
        value.toString() == '{}' ||
        (value is List && value.isEmpty == true)) return true;
    return false;
  }

  ///
  /// Check is date.
  ///
  ///
  static bool isDate(String s) {
    RegExp regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    // Check if the input matches the regex pattern
    if (!regex.hasMatch(s)) return false;

    // Split the input string into day, month, and year components

    List<String> parts = s.split('/');
    int? day = int.tryParse(parts[0]);
    int? month = int.tryParse(parts[1]);
    int? year = int.tryParse(parts[2]);

    // Check if the day, month, and year components are valid
    if (day == null || month == null || year == null) return false;
    if (day < 1 || day > 31 || month < 1 || month > 12 || year < 1000) {
      return false;
    }
    return true; // Valid date format
  }

  ///
  /// Check is number.
  ///
  ///
  static bool isNumeric(String s) {
    if (s == 'null') {
      return false;
    }

    return double.tryParse(s) != null || int.tryParse(s) != null;
  }

  ///
  /// Check nullOrEmpty
  ///
  static bool phoneNumber(String? value) {
    final RegExp reg = RegExp(r'^0[0-9]{9}$');
    if (nullOrEmpty(value)) {
      return false;
    }
    if (reg.hasMatch(value!)) {
      // phone validate
      return true;
    }

    return false;
  }

  ///
  /// Validate special characters.
  ///
  static bool hasSpecialCharacters(String input) {
    final pattern = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
    return pattern.hasMatch(input);
  }

  static bool isValidEmail(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    // true là hợp lệ
    return emailRegExp.hasMatch(email);
  }

  static bool isValidCCCD(String input) {
    return input.length >= 8;
  }

  ///
  /// Using to validate phone
  ///
  static String? handlePhoneValidate(String value) {
    const String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Số điện thoại không được để trống';
    } else if (!regExp.hasMatch(value)) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }
}
