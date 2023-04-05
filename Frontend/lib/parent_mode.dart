import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/daily_report.dart';

import 'full_report.dart';

class ParentMode extends StatefulWidget {
  const ParentMode({Key? key}) : super(key: key);

  @override
  State<ParentMode> createState() => _ParentModeState();
}

class _ParentModeState extends State<ParentMode> {

  String fName = '';
  String lName = '';

  ///////ADD THE DETAILSSSSSSSSS
  String userDOB = '';
  String fCName = '';
  String lCName = '';
  String speechLevel = '';
  String top_words = "No words";
  String result = 'Result Here';
  List resultList = [];
  List wordList = [];

  @override
  void initState() {
    getCurrentUser();
    getCurrentUserDOB();
    getData();
    super.initState();
  }

  Future<void> getCurrentUser() async {
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
    DocumentReference userDocRef = _firestore.collection('User_Collection').doc(currentUser.uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    if (!userDocSnapshot.exists) {
      // The user's document doesn't exist
      print('Error: User document not found');
      return;
    }

    // Get the user's DOB from the document
    if (mounted) {
      setState(() {
        fName = userDocSnapshot['Parent_First_Name'];
        lName = userDocSnapshot['Parent_Last_Name'];
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Column(
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
                        Icons.family_restroom,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "$fName $lName\nChild's Listening Status",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "Active",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(90.0),
                        color: Colors.green)),
                SizedBox(width: 10),
              ],
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Words Spoken Today",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Total",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            resultList.length.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_drop_up,
                            color: Colors.green,
                            size: 18,
                          ),
                          Text(
                            "10%",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Compared to yesterday",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "TOP WORDS",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    top_words,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: lightBlue,
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return DailyReport(resultList,wordList);
                              }));
                            },
                            child: Text(
                              "View Daily Report",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
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
                      Stack(children: [
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
                                    border:
                                    Border.all(width: 2, color: Colors.white),
                                    borderRadius: BorderRadius.circular(90.0),
                                    color: Colors.green)))
                      ]),
                      SizedBox(height: 30),
                      Text(
                        "Name: $fCName $lCName\n"
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
            Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FullReport(resultList,wordList);
                  }));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "View Full Report",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
    DocumentReference userDocRef =
    _firestore.collection('User_Collection').doc(currentUser.uid);
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
        fCName = userDocSnapshot['Child_First_Name'];
        lCName = userDocSnapshot['Child_Last_Name'];
        speechLevel = userDocSnapshot['Speech_Level'];
      });
    }

    if (userDOB == null) {
      // The user's DOB is not set in the document
      print('Error: DOB field not found or set to null');
    }
  }

  void getData() async {
    // Get a reference to the Firestore collection and document
    final collectionRef =
    FirebaseFirestore.instance.collection("Speaker_words");
    final documentRef = collectionRef.doc(FirebaseAuth.instance.currentUser?.email);

    // Retrieve the document snapshot
    final docSnapshot = await documentRef.get();

    // Check if the document exists
    if (docSnapshot.exists) {
      // Get the array from the document data
      final arrayData = docSnapshot.get("speak_word");

      // Convert the array to a list
      final List<dynamic> arrayAsList = List<dynamic>.from(arrayData);

      getTopWords(arrayAsList);
      resultList = arrayAsList;
    } else {
      // throw Exception('Document does not exist');

      resultList = [];
    }
  }

  void getTopWords(List<dynamic> arrayAsList) {
    var wordCount = <String, int>{};

    // loop through the list and increment the count for each word in the map
    for (var word in arrayAsList) {
      if (wordCount.containsKey(word)) {
        wordCount[word]= (wordCount[word] ?? 0) + 1;
      } else {
        wordCount[word] = 1;
      }
    }

    // sort the map by the count of each word in descending order
    var sortedWords = wordCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // create a list of maps containing the word and its count
    var wordCountList = wordCount.entries.map((entry) => {
      'word': entry.key,
      'count': entry.value,
    }).toList();

    wordList = wordCountList;
    print(wordList);
    // get the top two words in the sorted map
    var topTwoWords = sortedWords.take(2).map((e) => e.key).toList();

    if (topTwoWords.length==1){
      setState(() {
        top_words=topTwoWords[0];
        });
    }else
      {
        setState(() {
          top_words="${topTwoWords[0]},${topTwoWords[1]}";
        });
      }


  }
}
