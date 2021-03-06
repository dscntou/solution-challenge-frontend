class Validator {
  static String email(val) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val);
    if (!emailValid) return 'Error email format.';
    return null;
  }

  static String password(val) {
    if (val.length < 6) return 'The password must at least has 6 characters.';
    return null;
  }

  static String name(val) {
    if (val.length == 0) return 'Name cannot be empty.';
    return null;
  }
}
