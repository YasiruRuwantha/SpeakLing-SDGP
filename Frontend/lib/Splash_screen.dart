import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:frontend/select_mode.dart';

import 'login_form.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<SplashScreenWidget> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the new page using pushReplacementNamed
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginForm()));
        Navigator.push(context, MaterialPageRoute(builder: (context) {return LoginForm();}));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {return SelectMode();}));
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding:
                EdgeInsetsDirectional.fromSTEB(0.0, 200.0, 0.0, 0.0),
                child: Image.asset("assets/logo.png")
              ),
              Padding(
                padding:
                EdgeInsetsDirectional.symmetric(vertical: 100, horizontal: 120),
                child: Text(
                  'By Neuronet\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 21.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
