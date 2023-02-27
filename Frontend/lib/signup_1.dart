import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/login.dart';
import 'package:frontend/login_form.dart';

class Signup1 extends StatelessWidget {
  const Signup1({Key? key}) : super(key: key);

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
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: "Input your email",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none)),
                ),
              ),


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
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: "Input your username",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none)),
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
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: "Input your password",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none)),
                ),
              ),

              //password
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Confirm Password",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: "Input your password",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none)),
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
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return LoginForm();
                      }));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
