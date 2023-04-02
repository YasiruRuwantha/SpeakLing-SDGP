import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/login_form.dart';
import 'package:frontend/signup_child.dart';
import 'package:frontend/signup_parent.dart';

void main(){
  test('Validating the parent first name', (){
    var result = ParetnFNameValidator.validate("");
    expect(result, "First name cannot be empty!");
  }
  );

  test('Validating the parent last name', (){
    var result = ParetnLNameValidator.validate("");
    expect(result, "Last name cannot be empty!");
  }
  );

}