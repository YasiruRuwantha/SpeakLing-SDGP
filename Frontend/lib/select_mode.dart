import 'package:flutter/material.dart';
import 'package:frontend/child_mode.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/login.dart';
import 'package:frontend/login_form.dart';
import 'package:frontend/parent_mode.dart';
import 'package:frontend/signup_child.dart';

class SelectMode extends StatelessWidget {
  const SelectMode({Key? key}) : super(key: key);

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
              SizedBox(height: 150),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
                child: Image.asset("assets/logo.png"),
              ),
              Text(
                "Choose",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 60),

              //child mode
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: darkblue,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ChildMode();
                      }));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.child_care),
                        SizedBox(width: 15),
                        Text(
                          "Child Mode",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              //parent  mode
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: orange,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ParentMode();
                      }));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.family_restroom),
                        SizedBox(width: 15),
                        Text(
                          "Parent Mode",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
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
