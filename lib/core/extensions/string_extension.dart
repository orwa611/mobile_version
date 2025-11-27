extension StringExtension on String {
  bool isEmail() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }

  bool isValidPassword() {
    final passwordRegex = RegExp(r'^.{6,}$');
    return passwordRegex.hasMatch(this);
  }
}
