extension PasswordExtention on String {
  bool isCorrectPasswordLength() {
    return length >= 8;
  }

  bool isContainsOneCapital() {
    return contains(RegExp(r'[A-Z]'));
  }

  bool isContainsOneDigit() {
    return contains(RegExp(r'\d'));
  }

  bool isContainsOneSpecialSymbol() {
    return contains(RegExp(r'[!@#$%^&*]'));
  }
}
