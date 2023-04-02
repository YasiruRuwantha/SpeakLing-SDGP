import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/signup_child.dart';

void main(){

  test('Validating the child first name', () {
    var result = ChildFNameValidator.validate("");
    expect(result, "First name cannot be null");
  }
  );

  test('Validating the child last name', (){
    var result = ChildLNameValidator.validate("");
    expect(result, "Last name cannot be null");
  }
  );

  test('Validating the DOB', (){
    var result = ChildDOBValidator.validate("");
    expect(result, "DOB cannot be null");
  }
  );

  test('Validating the speech level', (){
    var result = ChildSpeechLevelValidator.validate("");
    expect(result, "Speech level cannot be null");
  }
  );

}