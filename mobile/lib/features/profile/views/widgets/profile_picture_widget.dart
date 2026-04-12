import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152.w,
      height: 152.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[350],
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person_rounded, size: 120, color: Colors.white),
    );
  }
}
