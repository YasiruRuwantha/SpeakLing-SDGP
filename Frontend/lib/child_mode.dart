import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';

class ChildMode extends StatefulWidget {
  const ChildMode({Key? key}) : super(key: key);

  @override
  State<ChildMode> createState() => _ChildModeState();
}

class _ChildModeState extends State<ChildMode> {
///////ADD THE DETAILSSSSSSSSS
  String userDOB = '';
  String fName = '';
  String lName = '';
  String speechLevel = '';

  @override
  void initState() {
    super.initState();
    getCurrentUserDOB();
  }

  Future<void> getCurrentUserDOB() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // Get the current user
    User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      // No user is signed in
      print('Error: No user is signed in');
      return;
    }

    // Fetch the user's document from Firestore using their uid
    DocumentReference userDocRef = _firestore.collection('User_Collection').doc(
        currentUser.uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    if (!userDocSnapshot.exists) {
      // The user's document doesn't exist
      print('Error: User document not found');
      return;
    }

    // Get the user's DOB from the document
    if (mounted) {
      setState(() {
        userDOB = userDocSnapshot['DOB'];
        fName = userDocSnapshot['Child_First_Name'];
        lName = userDocSnapshot['Child_Last_Name'];
        speechLevel = userDocSnapshot['Speech_Level'];
      });
    }

    if (userDOB == null) {
      // The user's DOB is not set in the document
      print('Error: DOB field not found or set to null');
    }
  }


  //Interpreter _interpreter;

  /* @override
  void initState() {
    super.initState();
    loadModel();
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Column(
        children: [
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 60,
                  child: Image.asset("assets/logo.png"),
                ),
                Column(
                  children: [
                    Icon(
                      Icons.child_care,
                      color: Colors.white,
                      size: 35,
                    ),
                    Text(
                      "Mode",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Profile",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: darkblue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/child.jpg"),
                            radius: 55,
                          ),
                          Positioned(
                              right: 10,
                              bottom: 0,
                              child: Container(
                                  padding: EdgeInsets.all(7.5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: Colors.white
                                      ),
                                      borderRadius: BorderRadius.circular(90.0),
                                      color: Colors.green
                                  )
                              )
                          )
                        ]
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Name: $fName $lName\n"
                          "DOB: $userDOB\n"
                          "Speech Level: $speechLevel",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Listening Status",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 20),
              Text(
                "Active",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Colors.white
                      ),
                      borderRadius: BorderRadius.circular(90.0),
                      color: Colors.green
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}