import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Utils.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/login.dart';
import 'package:frontend/login_form.dart';
import 'package:frontend/signup_child.dart';

class SignupParent extends StatefulWidget {
  //const SignupParent({Key? key}) : super(key: key);
  SignupParent({required this.emailId, required this.userId}) : super();
  String emailId;
  String userId;

  //SignupParent({Key key, required this.email}) : super(key : key);
  @override
  State<SignupParent> createState() => _SignupParentState();
}
class _SignupParentState extends State<SignupParent> {

  final formKey = GlobalKey<FormState>();
  final parentFName = TextEditingController();
  final parentLName = TextEditingController();


  @override
  dispose(){
    parentFName.dispose();
    parentLName.dispose();
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
                      "First name of the parent",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: TextFormField(
                    controller: parentFName,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: "Parent's first name",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (parentFName) => parentFName == null || parentFName == ''
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
                      "Last name of the parent",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: TextFormField(
                    controller: parentLName,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: "Parent's last name",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (parentLName) => parentLName == null || parentLName == ''
                        ? 'Field cannot be empty!'
                        : null,
                  ),
                ),

                //password
              /*
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Contact No",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        hintText: "+94 xxx xxx xxx",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                  ),
                ),
                */
                SizedBox(height: 40),

                //button
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: lightBlue,
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () {
                        /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return SignupChild();
                      }));*/
                        final isValid = formKey.currentState!.validate();
                        if(isValid) {
                          try{
                            String fName = parentFName.text.trim();
                            String lName = parentLName.text.trim();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupChild(
                                      parentFName: fName, parentLName: lName, emailId: widget.emailId, userId: widget.userId)),
                            );
                          } on FirebaseAuthException catch (error){
                            Utils.showSnackBarRed(error.message);
                          }
                        }

                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 15),
                          Icon(Icons.arrow_forward_ios),
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
}
