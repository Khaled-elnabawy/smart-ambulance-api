import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/routing/routes.dart';
import 'package:mobile/features/profile/views/edit_profile_view.dart';
import 'package:mobile/features/profile/views/profile_view.dart';
import 'package:mobile/features/requests/views/requests_view.dart';

import 'core/routing/app_router.dart';
import 'features/home/views/scheduled_form_view.dart';

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
        onGenerateRoute: appRouter.generateRoute,
        //initialRoute: Routes.loginView,
        home: ProfileView(),
      ),
    );
  }
}
