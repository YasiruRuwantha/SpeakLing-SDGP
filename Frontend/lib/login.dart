import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/login_form.dart';
import 'package:frontend/signup_1.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Text(
              "Welcome to",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 35),
              child: Image.asset("assets/logo.png"),
            ),
            SizedBox(height: 120),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginForm();
                }));
              },
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
                  "New user ?",
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
          ],
        ),
      ),
    );
  }
}
