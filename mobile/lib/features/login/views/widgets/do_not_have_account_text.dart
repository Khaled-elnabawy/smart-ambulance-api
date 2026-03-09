import 'package:flutter/material.dart';

import '../../../../core/theming/styles.dart';

class DoNotHaveAccountText extends StatelessWidget {
  const DoNotHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an account?',
            style: TextStyles.font13GrayMedium,
          ),
          TextSpan(
            text: ' Sign Up',
            style: TextStyles.font13RedBold,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
