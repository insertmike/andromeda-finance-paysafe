bool isValidEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return regex.hasMatch(value);
}

String isPasswordCompliant(String password) {
  bool hasUppercase = false;
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;

  if (password.isEmpty) {
    return 'Please insert at least one number, one capital letter and one symbol';
  }

  if (password.length < 8) {
    return 'Password should be at least 8 characters';
  }

  hasSpecialCharacters =
      password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  if (!hasSpecialCharacters) {
    return 'Password requires special character.';
  }

  password.runes.forEach((int currentCharacter) {
    var character = new String.fromCharCode(currentCharacter);
    if (_isdigit(character, 0)) {
      hasDigits = true;
    } else if (character == character.toUpperCase()) {
      hasUppercase = true;
    } else if (character == character.toLowerCase()) {
      hasLowercase = true;
    }
    if (hasUppercase && hasLowercase && hasDigits) {
      return null;
    }
  });

  return hasSpecialCharacters && hasUppercase && hasLowercase && hasDigits
      ? null
      : "Please insert at least one number, one capital letter and one symbol";
}

bool _isdigit(String s, int idx) =>
    "0".compareTo(s[idx]) <= 0 && "9".compareTo(s[idx]) >= 0;
