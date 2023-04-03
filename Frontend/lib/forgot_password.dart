import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/login_form.dart';

import 'Utils.dart';
import 'constants.dart';

class UserEmailValidator{
  static String? validate(String value){
    return value != null && !EmailValidator.validate(value)
        ? 'Enter a valid email!'
        :null;
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //Creating the variables
  final formKey = GlobalKey<FormState>();
  final userEmail = TextEditingController();

  @override
  void dispose(){
    userEmail.dispose();
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
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 35),
                    child: Image.asset("assets/logo.png"),
                  ),
                  SizedBox(height: 30),

                  //email
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "Email",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    child: TextFormField(
                      controller:userEmail,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Input your email",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) => UserEmailValidator.validate(email!),
                    ),
                  ),
                  SizedBox(height: 40),
                  //button
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: lightBlue,
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: resetPassword,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Reset Password",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(width: 15),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  Future resetPassword() async{
    try{
      String email = userEmail.text.trim();
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email);
      Utils.showSnackBarGreen('Email is successfully sent to $email');
    } on FirebaseAuthException catch(error){
      Utils.showSnackBarRed(error.message);
    }
  }

}
