import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helpers/extensions.dart';
import 'package:mobile/core/helpers/spacing.dart';
import 'package:mobile/core/routing/routes.dart';
import 'package:mobile/core/theming/colors.dart';
import 'package:mobile/core/theming/styles.dart';
import 'package:mobile/features/profile/views/widgets/logout_bloc_listener.dart';
import 'package:mobile/features/profile/views/widgets/profile_data_widget.dart';
import 'package:mobile/features/profile/views/widgets/profile_picture_widget.dart';
import 'package:mobile/features/profile/data/models/edit_profile/edit_profile_response_model.dart';

import '../logic/logout/logout_cubit.dart';

class ProfileView extends StatefulWidget {
  final String userName;
  final String email;
  final String phoneNumber;
  final String token;
  final double rating;
  final bool isDriver;

  const ProfileView({
    super.key,
    required this.token,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.isDriver,
    required this.rating,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late String userName;
  late String email;
  late String phoneNumber;

  @override
  void initState() {
    super.initState();
    userName = widget.userName;
    email = widget.email;
    phoneNumber = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 648.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 520.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpacing(36),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Personal Information',
                              style: TextStyles.font18BlackMedium,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final result = await context.pushNamed(
                                  Routes.editProfileView,
                                  arguments: widget.token,
                                );
                                if (result != null && result is EditProfileResponseModel) {
                                  setState(() {
                                    userName = result.data?.userData?.name ?? userName;
                                    email = result.data?.userData?.email ?? email;
                                    phoneNumber = result.data?.userData?.phone ?? phoneNumber;
                                  });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.edit_rounded,
                                    color: ColorsManager.red,
                                    size: 24,
                                  ),
                                  horizontalSpacing(4),
                                  Text('Edit', style: TextStyles.font14RedBold),
                                ],
                              ),
                            ),
                          ],
                        ),
                        verticalSpacing(24),
                        ProfileDataWidget(
                          icon: Icons.person_rounded,
                          title: 'User Name',
                          value: userName,
                        ),
                        ProfileDataWidget(
                          icon: Icons.email_rounded,
                          title: 'Email',
                          value: email,
                        ),
                        ProfileDataWidget(
                          icon: Icons.phone_rounded,
                          title: 'Phone Number',
                          value: phoneNumber,
                        ),
                        widget.isDriver ? ProfileDataWidget(
                          icon: Icons.star_rounded,
                          title: 'OverAll Rating',
                          value: widget.rating.toString(),
                        ): SizedBox.shrink(),
                        verticalSpacing(44),
                        Text('Settings', style: TextStyles.font18BlackMedium),
                        verticalSpacing(24),
                        GestureDetector(
                          onTap: () {
                            context.read<LogoutCubit>().emitLogoutState(
                              token: widget.token,
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.login_rounded,
                                size: 20,
                                color: ColorsManager.red,
                              ),
                              horizontalSpacing(8),
                              Text('Logout', style: TextStyles.font16RedBold),
                            ],
                          ),
                        ),
                        LogoutBlocListener(),
                      ],
                    ),
                  ),
                ),
                Positioned(top: 0, child: ProfilePictureWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
