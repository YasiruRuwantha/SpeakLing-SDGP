import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/forgot_password.dart';
import 'package:frontend/select_mode.dart';
import 'package:frontend/signup_1.dart';

import 'Utils.dart';

class UserEmailValidator{
  static String? validate(String value){
    return value != null && !EmailValidator.validate(value)
        ? 'Enter a valid email!'
        :null;
  }
}

class UserPasswordValidator{
  static String? validate(String value){
    return value != null && value.length < 6
        ? 'Enter minimum of 6 characters!'
        : null;
  }
}

class LoginForm extends StatefulWidget{
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();

  @override
  dispose(){
    userEmail.dispose();
    userPassword.dispose();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                "Welcome back,",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 50, horizontal: 35),
                child: Image.asset("assets/logo.png"),
              ),
              SizedBox(height: 30),

              //username
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Username",
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

              //password
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Password",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: TextFormField(
                  controller: userPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: "Input your password",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => UserPasswordValidator.validate(value!),
                ),
              ),

              //forgot password
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ForgotPassword();
                  }));
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),

              //button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: lightBlue,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: logIn,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 15),
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Signup1();
                      }));
                    },
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: (){
                  
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Image.network(
                    'https://i0.wp.com/nanophorm.com/wp-content/uploads/2018/04/google-logo-icon-PNG-Transparent-Background.png?w=1000&ssl=1',
                    width: 45,
                    height: 45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Future logIn() async{
    try{
      String email = userEmail.text.trim();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: userPassword.text.trim()
      );
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          SelectMode()), (Route<dynamic> route) => false);
      Utils.showSnackBarGreen('Log in successful as $email');
    } on FirebaseAuthException catch(error){
      Utils.showSnackBarRed(error.message);
    }
  }
}
