import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helpers/spacing.dart';
import 'package:mobile/core/widgets/generic_text_button.dart';
import 'package:mobile/core/widgets/generic_text_form_field.dart';
import 'package:mobile/features/login/views/widgets/do_not_have_account_text.dart';

import '../../../core/theming/styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/images/login_background_vector.png',
                fit: BoxFit.fill,
                width: 440.w,
                height: 482.h,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpacing(81),
                    SizedBox(
                      width: 324.w,
                      child: Text(
                        "Welcome Back 👋",
                        style: TextStyles.font55WhiteBold.copyWith(
                          height: 1.25.h,
                        ),
                      ),
                    ),
                    verticalSpacing(237),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          GenericTextFormField(hintText: 'Phone Number , Email'),
                          verticalSpacing(16),
                          GenericTextFormField(
                            hintText: 'Password',
                            isObscureText: isObscureText,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isObscureText = !isObscureText;
                                });
                              },
                              child: Icon(
                                isObscureText
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                color: Colors.black.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                          verticalSpacing(35),
                          GenericTextButton(
                            buttonText: 'Login',
                            textStyle: TextStyles.font24WhiteBold,
                            onPressed: () {},
                          ),
                          verticalSpacing(60),
                          DoNotHaveAccountText(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
