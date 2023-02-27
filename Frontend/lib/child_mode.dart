import 'package:flutter/material.dart';

class ChildMode extends StatelessWidget {
  const ChildMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Image.asset("assets/logo.pmg"),
              Icon(Icons.child_care),
            ],
          ),
        ],
      ),
    );
  }
}
