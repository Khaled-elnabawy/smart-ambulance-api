import 'package:flutter/material.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/generic_text_form_field.dart';

class TitleAndTextFieldWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;

  const TitleAndTextFieldWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.font16BlackMedium),
        verticalSpacing(8),
        GenericTextFormField(
          controller: controller,
          hintText: hintText,
          hintStyle: TextStyles.font16LightGrayRegular,
          enableBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.lightGrey, width: 1.2),
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid value';
            }
            return null;
          },
        ),
      ],
    );
  }
}
