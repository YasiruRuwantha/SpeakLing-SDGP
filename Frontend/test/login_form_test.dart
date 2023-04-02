import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/login_form.dart';

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

  test('Validating the password', (){
    var result = UserPasswordValidator.validate("1234");
    expect(result, "Enter minimum of 6 characters!");
  }
  );

  test('Validating the password', (){
    var result = UserPasswordValidator.validate("");
    expect(result, "Enter minimum of 6 characters!");
  }
  );
}