import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/di/dependency_injection.dart';
import 'package:mobile/core/routing/app_router.dart';
import 'package:mobile/smart_ambulance.dart';

void main() async{
  setupGetIt();
  await ScreenUtil.ensureScreenSize();
  runApp(SmartAmbulance(appRouter: AppRouter()));
}
