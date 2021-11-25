import 'package:email_validator/email_validator.dart';

String? nameValidation(String? text) {
  text ??= '';
  if (text.isEmpty) {
    return 'Name must not be empty';
  } else if (text.length > 25) {
    return 'Name must not be over 25 characters';
  }

  return null;
}

String? emailValidation(String? email) {
  email ??= '';
  if (!EmailValidator.validate(email)) return 'Not a valid email address';

  return null;
}

String? passwordValidation(String? password) {
  password ??= '';
  if (password.length < 8) {
    return 'Password must have a minimum of 8 characters';
  }

  return null;
}

String? passwordMatched(String? password, String? retypedPassword) {
  password ??= '';
  retypedPassword ??= '';
  if (password != retypedPassword) return 'Password does not matched';

  return null;
}

String? phoneNumberValidation(String? phoneNumber) {
  phoneNumber ??= '';
  if (phoneNumber.length < 10 || phoneNumber.length > 13) {
    return 'Phone Number not valid';
  }

  return null;
}

String? isEmptyFieldValidation(String? value) {
  value ??= '';
  if (value.isEmpty) {
    return 'Must not be empty';
  }

  return null;
}

String? dropdownValidation(var item) {
  if (item == null) {
    return 'An item from dropdown must be selected';
  }

  return null;
}
