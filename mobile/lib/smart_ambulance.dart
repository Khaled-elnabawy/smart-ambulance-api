import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmartAmbulance extends StatelessWidget {
  const SmartAmbulance({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Smart Ambulance App",
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: Scaffold(body: Center(child: Text("smart ambulance app"))),
      ),
    );
  }
}
