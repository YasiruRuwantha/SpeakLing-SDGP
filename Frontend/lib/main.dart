import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/login_form.dart';
import 'package:frontend/select_mode.dart';
import 'package:frontend/Utils.dart';

import 'Splash_screen.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    scaffoldMessengerKey: Utils.messengerKey,
      home: SplashScreen(),
    );
    }
}

// class Login extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     body: StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context,snapshot){
//         if(snapshot.hasData){
//           return SelectMode();
//         }
//         else{
//           return LoginForm();
//         }
//       }
//     )
//   );
// }


















