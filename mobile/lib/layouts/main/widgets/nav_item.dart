import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/theming/styles.dart';

class NavItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> iconsUnelected = [
      'assets/svgs/home_unselected.svg',
      'assets/svgs/notifications_unselected.svg',
      'assets/svgs/profile_unselected.svg',
    ];
    final List<String> iconsSelected = [
      'assets/svgs/home_selected.svg',
      'assets/svgs/notifications_selected.svg',
      'assets/svgs/profile_selected.svg',
    ];
    final List<String> titles = ['Home', 'Notifications', 'Profile'];
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16.w : 0,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(44),
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              isSelected ? iconsSelected[index] : iconsUnelected[index],
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: isSelected
                  ? Row(
                      children: [
                        SizedBox(width: 8.w),
                        Text(
                          titles[index],
                          style: TextStyles.font13WhiteMedium,
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
