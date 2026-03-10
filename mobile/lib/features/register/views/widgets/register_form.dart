import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/generic_text_form_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isPasswordObscureText = true;
  bool isPasswordConfirmationObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<RegisterCubit>().formKey,
      child: Column(
        children: [
          GenericTextFormField(
            hintText: 'Name',
            controller: context.read<RegisterCubit>().nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid name';
              }
            },
          ),
          GenericTextFormField(
            hintText: 'Phone Number',
            controller: context.read<RegisterCubit>().phoneNumberController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid phone number';
              }
            },
          ),
          GenericTextFormField(
            hintText: 'National Id',
            controller: context.read<RegisterCubit>().nationalIdController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid national id';
              }
            },
          ),
          GenericTextFormField(
            hintText: 'Email',
            controller: context.read<RegisterCubit>().emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid email';
              }
            },
          ),
          verticalSpacing(16),
          GenericTextFormField(
            hintText: 'Password',
            isObscureText: isPasswordObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscureText = !isPasswordObscureText;
                });
              },
              child: Icon(
                isPasswordObscureText
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
              ),
            ),
            controller: context.read<RegisterCubit>().passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
            },
          ),
          GenericTextFormField(
            hintText: 'Confirmation Password',
            isObscureText: isPasswordObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscureText = !isPasswordObscureText;
                });
              },
              child: Icon(
                isPasswordObscureText
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
              ),
            ),
            controller: context
                .read<RegisterCubit>()
                .confirmationPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid confirmation password';
              }
            },
          ),
        ],
      ),
    );
  }
}
