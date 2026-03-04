import 'package:flutter/material.dart';

class SmartAmbulance extends StatelessWidget {
  const SmartAmbulance({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smart Ambulance App",
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(body: Center(child: Text("smart ambulance app"))),
    );
  }
}
