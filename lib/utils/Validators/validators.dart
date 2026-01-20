class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    if (value.trim().length > 100) {
      return "Email excedded more than 100 characters";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "Invalid email format";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }
    if (value.trim().length < 8) {
      return "Password must be at least 8 characters long";
    }
    if (value.trim().length > 16) {
      return "Password must not exceed 16 characters";
    }
    return null;
  }

  static String? confirmPassword(String? value, String? confirmValue) {
    if (confirmValue == null || confirmValue.trim().isEmpty) {
      return "Confirm password is required";
    } else if (value != confirmValue.trim()) {
      return "Passwords do not match";
    }
    if (confirmValue.trim().length > 16) {
      return "Password must not exceed 16 characters";
    }
    return null;
  }
}
