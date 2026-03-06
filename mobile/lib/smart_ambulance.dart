import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/routing/routes.dart';

import 'core/routing/app_router.dart';

class SmartAmbulance extends StatelessWidget {
  final AppRouter appRouter;

  const SmartAmbulance({super.key, required this.appRouter});

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
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.loginView,
      ),
    );
  }
}
