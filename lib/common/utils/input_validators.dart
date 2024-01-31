import 'package:clock/clock.dart';
import 'package:validators/validators.dart' as validator;

class InputValidators {
  static String? empty(String _) => null;

  static String? validateEmailAddress(String input) {
    if (input.trim().isEmpty) {
      return 'Required field';
    }

    if (!validator.isEmail(input.trim())) {
      return 'Invalid email';
    }

    return null;
  }

  static String? validateBio(String input) {
    if (input.trim().isEmpty) {
      return 'Bio cannot be empty';
    }

    return null;
  }

  static String? validateName(String input, {String? title}) {
    if (input.trim().isEmpty) {
      return '${title ?? 'Name field'} is required';
    } else if (input.trim().length < 3) {
      return '${title ?? 'Name'} should be at least 3 characters.';
    }
    return null;
  }

  static String? validateUsername(String input, {String? title}) {
    final RegExp usernameRegex = RegExp(r'^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{0,29}$');
    if (input.trim().isEmpty) {
      return '${title ?? 'Username'} field is required';
    } else if (!usernameRegex.hasMatch(input)) {
      return 'Should not contain special characters except _';
    } else if (input.trim().length < 3) {
      return '${title ?? 'Username'} should be at least 3 characters';
    }
    return null;
  }

  static String? validatePassword(String input) {
    if (input.isEmpty) {
      return 'Field is required';
    }
    final bool containsUpperCase = input.contains(RegExp('[A-Z]'));
    final bool containsDigit = input.contains(RegExp('[0-9]'));
    final bool containsLowerCase = input.contains(RegExp('[a-z]'));

    if (!containsLowerCase) {
      return 'Password should contain at least one lower case letter';
    }
    if (!containsUpperCase) {
      return 'Password should contain at least one upper case letter';
    }
    if (!containsDigit) {
      return 'Password should contain at least one digit';
    }
    if (input.length < 8) {
      return 'Minimum of 8 characters';
    }
    return null;
  }

  static String? isRequired(String? input, {String message = 'Field cannot be empty'}) {
    return input == null ? message : null;
  }

  static String? minimumLength(String input, {required int length, String? message}) {
    if (input.length < length) {
      return message ?? 'Should be at least $length characters';
    }
    return null;
  }

  static String? validateMinimumAge({
    required DateTime dateOfBirth,
    required int minimumAge,
    String? errorMessage,
  }) {
    if ((clock.now().difference(dateOfBirth).inDays / 365).round() < minimumAge) {
      return errorMessage ?? 'You should be at least $minimumAge years old';
    }

    return null;
  }
}
