import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/theming/colors.dart';
import 'package:mobile/layouts/main/navigation/navigation_keys.dart';
import 'package:mobile/layouts/main/widgets/nav_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82.h,
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: ColorsManager.red,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(NavigationKeys.navigatorKeys.length, (index) {
          return NavItem(
            index: index,
            isSelected: currentIndex == index,
            onTap: () {
              onTap(index);
            },
          );
        }),
      ),
    );
  }
}
