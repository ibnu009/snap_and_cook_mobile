extension StringConverter on String {
  bool isEmailValid() {
    RegExp regex = RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if (regex.hasMatch(this)) {
      return true;
    } else {
      return false;
    }
  }

  String formatToIdnPhone() {
    if (startsWith("0")) {
      String phoneNumber = replaceFirst("0", "+62");
      return phoneNumber;
    }
    return "+${trim()}";
  }

}
