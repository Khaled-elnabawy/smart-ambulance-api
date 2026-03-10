import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'If you already have an account, please',
            style: TextStyles.font13GrayMedium,
          ),
          TextSpan(
            text: ' Login',
            style: TextStyles.font16RedBold,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.pushReplacementNamed(Routes.loginView);
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
