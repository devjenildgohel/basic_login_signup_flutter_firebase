class validations {
  bool validateEmail(String value) {
    if (value.isEmpty) {
      return false;
    }
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return false;
    }
    return true;
  }

  bool validatePassword(String value) {
    if (value.isEmpty) {
      return false;
    }
    if (value.length < 6) {
      return false;
    }
    return true;
  }
}
