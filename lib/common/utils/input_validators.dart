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

  static String? validateLoginEmailAddress(String input) {
    if (input.trim().isEmpty) {
      return 'Required field';
    }

    return null;
  }

  static String? validateName(String input, {String? title}) {
    if (input.trim().isEmpty) {
      return '${title ?? 'Name'} field is required';
    } else if (input.trim().length < 3) {
      return '${title ?? 'Name'} should be at least 3 characters';
    }
    return null;
  }

  static String? validateNumber(String input) {
    if (input.trim().isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  static String? validateDescription(String input) {
    if (input.trim().isEmpty) {
      return 'Descripton field is required';
    }
    return null;
  }

  static String? validateStaffCode(String input) {
    if (input.trim().isEmpty) {
      return 'Staff code field is required';
    }
    if (input.trim().length > 6 || input.trim().length < 6) {
      return 'Staff code should be 6 digits';
    }
    return null;
  }

  static String? validateBusinessCode(String input) {
    if (input.trim().isEmpty) {
      return 'Business code field is required';
    }
    if (input.trim().length > 8 || input.trim().length < 8) {
      return 'Business code should be 8 digits';
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

  static String? validateWiseFormField(
    String input,
    String? regex,
    String label, {
    bool isRequired = false,
    int? minLength,
    int? maxLength,
  }) {
    RegExp? validationRegex;
    if (regex != null) {
      validationRegex = RegExp(regex);
    }
    if (input.trim().isEmpty && isRequired) {
      return '$label field is required';
    } else if (validationRegex != null && !validationRegex.hasMatch(input)) {
      return 'Invalid ${label.toLowerCase()} provivded.';
    }
    if (minLength != null && input.length < minLength) {
      return 'Minimum of $minLength characters';
    }
    if (maxLength != null && input.length > maxLength) {
      return 'Maximum of $maxLength characters';
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

  static String? validateLoginPassword(String input) {
    if (input.isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  static String? verifyEmailCodeCode(String input) {
    if (input.isEmpty) {
      return 'Required field';
    }
    final int? code = int.tryParse(input);
    return input.toString().length == 6 && code != null ? 'Invalid PinCode' : null;
  }

  static String? validateAddress(String input) {
    final RegExp regex = RegExp(r'^(bc1|[13])[a-zA-HJ-NP-Z0-9]{25,39}$');
    if (regex.hasMatch(input)) {
      return null;
    }
    return 'Invalid Address';
  }

  // not a solid usdc validator
  static String? validateUDSC(String input) {
    if (input.toLowerCase().startsWith('0x')) {
      return null;
    }
    return 'Invalid Address';
  }

  static String? validatePin(String? input) {
    if (input == null) {
      return 'Required field';
    }
    if (input.isEmpty) {
      return 'Required field';
    }
    if (!validator.isNumeric(input)) {
      return 'Invalid Pin';
    }
    final int? code = int.tryParse(input);
    if (code == null) {
      return 'Invalid Pin';
    }
    return input.length == 6 ? null : 'Invalid PinCode';
  }

  static String? isRequired(String? input, {String message = 'Required field'}) {
    return input == null ? message : null;
  }

  static String? validateConfirmPassword({
    required String password,
    required String newPassword,
  }) {
    return password == newPassword ? null : 'Passwords does not match';
  }

  static String? validateConfirmPin({
    required String pin,
    required String newPin,
  }) {
    return pin == pin ? null : 'Pins do not match';
  }

  static String? isIdentical({
    required String input1,
    required String input2,
    required String message,
  }) {
    return input1 == input2 ? null : message;
  }

  static String? validateNigerianMobilePhoneNumber({
    required String nigerianNumberWithoutCountryCode,
  }) {
    final String input = nigerianNumberWithoutCountryCode.trim();
    if (input.isEmpty) {
      return 'Field is required';
    }
    if (!validator.isNumeric(input)) {
      return 'Invalid Input';
    }
    return InputValidators.length(
      input,
      length: input.startsWith('0')
          ? 11
          : input.startsWith('+234')
              ? 14
              : input.startsWith('234')
                  ? 13
                  : 10,
      message: 'Invalid nigerian phone number',
    );
  }

  static String? validateBankVerificationNumber(String input) {
    if (input.isEmpty) {
      return 'Field is required';
    }
    if (!validator.isNumeric(input)) {
      return 'Invalid Bank Verification Number (BVN)';
    }
    return InputValidators.length(input, length: 11, message: 'Invalid Bank Verification Number (BVN)');
  }

  static String? validateBankAccountNumber(String input) {
    if (input.isEmpty) {
      return 'Field is required';
    }
    if (!validator.isNumeric(input)) {
      return 'Invalid Bank Account';
    }
    return InputValidators.length(input, length: 10, message: 'Invalid Bank Account Number (NUBAN)');
  }

  static String? length(String input, {required int length, String? message}) {
    if (input.length != length) {
      return message ?? 'Should be $length characters';
    }
    return null;
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

  static String? validateExpiryDateTime(DateTime? expiringDate) {
    if (expiringDate == null) {
      return 'Please select date';
    }
    if (expiringDate.isBefore(clock.now().add(const Duration(days: 30)))) {
      return 'Expiring date is too close';
    }
    return null;
  }
}
