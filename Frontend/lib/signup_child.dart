import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Utils.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/login.dart';
import 'package:frontend/login_form.dart';
import 'package:frontend/select_mode.dart';

class SignupChild extends StatefulWidget {
  //const SignupChild({Key? key}) : super(key: key);
  SignupChild({required this.parentFName, required this.parentLName, required this.emailId, required this.userId}) : super();
  String parentFName;
  String parentLName;
  String emailId;
  String userId;

  @override
  State<SignupChild> createState() => _SignupChildState();
}

class _SignupChildState extends State<SignupChild> {
  bool selected = false;

  final formKey = GlobalKey<FormState>();
  final childFName = TextEditingController();
  final childLName = TextEditingController();
  final dob = TextEditingController();
  final speechLevel = TextEditingController();


  dispose(){
    childFName.dispose();
    childLName.dispose();
    dob.dispose();
    speechLevel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Welcome back,",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
                  child: Image.asset("assets/logo.png"),
                ),

                Text(
                  "Fill the parents' details",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 30),
                //email
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "First name of the child",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: TextFormField(
                    controller: childFName,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: "Child's first name",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (childFName) => childFName == null || childFName == ''
                        ? 'Field cannot be empty!'
                        : null,
                  ),
                ),

                //username
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Last name of the child",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: TextFormField(
                    controller: childLName,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: "Child's last name",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (childLName) => childLName == null || childLName == ''
                        ? 'Field cannot be empty!'
                        : null,
                  ),
                ),

                //password
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Date of Birth",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: TextFormField(
                    controller: dob,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: "yyyy/mm/dd",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (dob) => dob == null || dob == ""
                        ? 'Invalid input!'
                        : null,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Child's Speech Level",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: TextFormField(
                    controller: speechLevel,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: "Babbling,Holophrastic, Two-word stage",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (speechLevel) => speechLevel == null || speechLevel == ''
                        ? 'Field cannot be empty!'
                        : null,
                  ),
                ),

                CheckboxListTile(
                  value: selected,
                  onChanged: (value) {
                    setState(() {
                      selected = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    "I agree with Terms & Privacy",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 40),

                //button
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: lightBlue,
                          padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed:() {
                        createUser();

                      } ,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Finish Signing Up",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 15),
                          Icon(Icons.check),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*Stream<List<User>> readUser() => FirebaseFirestore.instance
      .collection('User_Collection')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());*/

  Future createUser() async {
    final isValid = formKey.currentState!.validate();
    //var firebaseUser = await FirebaseAuth.instance.currentUser();

    if (isValid && selected) {
      try{
        final addUser = FirebaseFirestore.instance.collection('User_Collection').doc(widget.userId);


        final user = User(
          parentFName: widget.parentFName,
          parentLName: widget.parentLName,
          childFName: childFName.text.trim(),
          childLName: childLName.text.trim(),
          dob: dob.text.trim(),
          speechLevel: speechLevel.text.trim(),
          userId: widget.userId,
          email: widget.emailId,
        );

        final json = user.toJson();
        Utils.showSnackBarGreen('Data has been saved successfully');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SelectMode();
        }));
        await addUser.set(json);
      } on FirebaseAuthException catch (error){
        Utils.showSnackBarRed(error.message);
      }
    }
    else{
      Utils.showSnackBarRed('You must agree to our terms and conditions!');
    }

  }

}
class User {

  final String parentFName;
  final String parentLName;
  final String childFName;
  final String childLName;
  final String dob;
  final String speechLevel;
  String? userId;
  final String email;

  User({
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
