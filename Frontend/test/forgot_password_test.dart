import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/forgot_password.dart';

void main(){

  test('Validating the null email', () {
    var result = UserEmailValidator.validate("test");
    expect(result, "Enter a valid email!");
  }
  );

  test('Validating the invalid email', () {
    var result = UserEmailValidator.validate("");
    expect(result, "Enter a valid email!");
  }
  );

  test('Validating the invalid email', () {
    var result = UserEmailValidator.validate("test.com");
    expect(result, "Enter a valid email!");
  }
  );

  test('Validating the invalid email', () {
    var result = UserEmailValidator.validate("test@gmailcom");
    expect(result, "Enter a valid email!");
  }
  );

}