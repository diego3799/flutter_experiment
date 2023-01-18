import 'package:email_validator/email_validator.dart';

String? notEmptyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter a valid value";
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter your email";
  }
  if (!EmailValidator.validate(value)) {
    return "Enter a valid email";
  }
  return null;
}
