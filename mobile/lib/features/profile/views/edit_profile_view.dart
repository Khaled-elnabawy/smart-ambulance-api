import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helpers/spacing.dart';
import 'package:mobile/features/profile/views/widgets/title_and_text_field_widget.dart';
import '../../../core/helpers/extensions.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/back_button_widget.dart';
import '../../../core/widgets/generic_text_button.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            verticalSpacing(16),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0.w),
                child: BackButtonWidget(),
              ),
            ),
            Spacer(),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 500.h,
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
                      children: [
                        verticalSpacing(36),
                        TitleAndTextFieldWidget(
                          title: 'User Name',
                          hintText: 'please enter new user name',
                        ),
                        verticalSpacing(16),
                        TitleAndTextFieldWidget(
                          title: 'Email',
                          hintText: 'please enter new email',
                        ),
                        verticalSpacing(16),
                        TitleAndTextFieldWidget(
                          title: 'Phone Number',
                          hintText: 'please enter new phone number',
                        ),
                        verticalSpacing(48),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GenericTextButton(
                              buttonText: 'Save Changes',
                              textStyle: TextStyles.font16WhiteBold,
                              buttonHeight: 45.h,
                              buttonWidth: 188.w,
                              onPressed: () {},
                            ),
                            GenericTextButton(
                              buttonText: 'Cancel',
                              textStyle: TextStyles.font16RedBold,
                              buttonHeight: 45.h,
                              buttonWidth: 188.w,
                              backgroundColor: Colors.white,
                              isHaveBorder: true,
                              onPressed: () {
                                context.pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
