class UserModel {

  final String parentFName;
  final String parentLName;
  final String childFName;
  final String childLName;
  final String dob;
  final String speechLevel;
  String? userId;
  final String email;

  UserModel({
    required this.parentFName,
    required this.parentLName,
    required this.childFName,
    required this.childLName,
    required this.dob,
    required this.speechLevel,
    this.userId = '',
    required this.email,
  });

  Map<String, dynamic> toJson() =>{
    'Parent_First_Name': parentFName,
    'Parent_Last_Name': parentLName,
    'Child_First_Name': childFName,
    'Child_Last_Name': childLName,
    'DOB': dob,
    'Speech_Level': speechLevel,
    'User_Id': userId,
    'Email': email,
  };

}