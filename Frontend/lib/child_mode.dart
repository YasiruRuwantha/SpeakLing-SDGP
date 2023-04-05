import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:tflite_audio/tflite_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildMode extends StatefulWidget {
  const ChildMode({Key? key}) : super(key: key);

  @override
  State<ChildMode> createState() => _ChildModeState();
}

class _ChildModeState extends State<ChildMode> {
  final isRecording = ValueNotifier<bool>(false);
  Stream<Map<dynamic, dynamic>>? recognitionStream; //Declare stream value

  ///values for google's teachable machine model
  final String model =
      'assets/speakling-speech.tflite'; //path to model(.tflite) file
  final String label = 'assets/speak.txt'; //path to labels(.txt) file
  final String inputType = 'rawAudio';
  final int sampleRate = 44100;
  final int bufferSize = 11016;

  // Get the current date and time
  DateTime currentDate = DateTime.now();
  late DateTime _lastLoginDate;

  ///Optional parameters you can adjust to modify your input and output
  final bool outputRawScores = false;
  final int numOfInferences =
      10; //10 recording(1s to 2s) rounds per one click on "LISTEN MODE"
  final int numThreads = 1;
  final bool isAsset = true;

  ///Adjust the values below when tuning model detection.
  final double detectionThreshold = 0.3;
  final int averageWindowDuration = 1000;
  final int minimumTimeBetweenSamples = 30;
  final int suppressionTime = 1500;

///////ADD THE DETAILSSSSSSSSS
  String userDOB = '';
  String fName = '';
  String lName = '';
  String speechLevel = '';
  String result = 'Result Here';
  List resultList = [];

  @override
  void initState() {
    super.initState();
    getCurrentUserDOB();
    _getLastLoginDate();

    ///load Tflite_audio model
    TfliteAudio.loadModel(model: model, label: label, inputType: 'rawAudio');

    ///update UI every 0.1 seconds
    // Timer.periodic(Duration(milliseconds: 100), (timer) {
    //   setState(() {});
    // });
  }

  Future<void> getResult() async {
    ///Recording & Recognition
    recognitionStream = await TfliteAudio.startAudioRecognition(
      sampleRate: sampleRate,
      bufferSize: bufferSize,
      numOfInferences: numOfInferences,
    );

    ///Listen for results
    recognitionStream?.listen((event) {
      setState(() {
        result = event["recognitionResult"].toString();
        if (result=="background"){
          result="Background Noise";
        }
      });
    }).onDone(() {
      // Do something when recognition is done
      isRecording.value = false;
      if ((result != 'Result Here')&&(result != 'background')) resultList.add(result);
      saveData();
      setState(() {
        result = 'Result Here';
      });
    });
  }

  @override
  void dispose() {
    _updateLastLoginDate();
    super.dispose();
  }

  User? currentUser;

  Future<void> getCurrentUserDOB() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // Get the current user
    currentUser = _auth.currentUser;

    if (currentUser == null) {
      // No user is signed in
      print('Error: No user is signed in');
      return;
    }

    // Fetch the user's document from Firestore using their uid
    DocumentReference userDocRef =
        _firestore.collection('User_Collection').doc(currentUser?.uid);
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

  @override
  Widget build(BuildContext context) {
    /// variables that depends on isRecording.value

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
                isRecording.value ? 'Active' : 'Inactive',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 10),
              Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(90.0),
                      color: isRecording.value ? Colors.green : Colors.red))
            ],
          ),
          SizedBox(height: 70),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 80),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () async {
              if (isRecording.value) {
                if ((result != 'Result Here')&&(result != 'background')) resultList.add(result);
                await saveData();
                setState(() {
                  result = 'Result Here';
                });
                log('Audio Recognition Stopped');
                TfliteAudio
                    .stopAudioRecognition(); //stop audio recognition if button is pressed while listening
                setState(() {
                  isRecording.value = false;
                });
              } else {
                setState(() {
                  isRecording.value = true;
                });
                await getResult(); //start recording and recognition procedure
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(Icons.family_restroom)),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    isRecording.value ? 'Listening' : 'LISTEN MODE',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Text(
            result,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getLastLoginDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _lastLoginDate =
        DateTime.parse(prefs.getString('lastLoginDate') ?? '2000-01-01');

    String formattedCurrentDate =
        "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";
    String formattedLastDate =
        "${_lastLoginDate.year}-${_lastLoginDate.month.toString().padLeft(2, '0')}-${_lastLoginDate.day.toString().padLeft(2, '0')}";

    if (formattedLastDate.compareTo(formattedCurrentDate) < 0) {
      print("new Day");
      resultList = [];
    } else {
      print("today");
      resultList = await getData();
      print(resultList);
    }
  }

  Future<void> _updateLastLoginDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lastLoginDate', DateTime.now().toString());
    _lastLoginDate = DateTime.now();
    print(_lastLoginDate);
  }

  saveData() {
    Map<String, dynamic> data = {"speak_word": resultList};

    FirebaseFirestore.instance
        .collection("Speaker_words")
        .doc(currentUser?.email)
        .set(data);
  }

  Future<List> getData() async {
    // Get a reference to the Firestore collection and document
    final collectionRef =
        FirebaseFirestore.instance.collection("Speaker_words");
    final documentRef = collectionRef.doc(currentUser?.email);

    // Retrieve the document snapshot
    final docSnapshot = await documentRef.get();

    // Check if the document exists
    if (docSnapshot.exists) {
      // Get the array from the document data
      final arrayData = docSnapshot.get("speak_word");

      // Convert the array to a list
      final List<dynamic> arrayAsList = List<dynamic>.from(arrayData);

      return arrayAsList;
    } else {
      // throw Exception('Document does not exist');

      return [];
    }
  }
}
