import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/networking/api_result.dart';
import '../data/models/send_reset_code_models/send_code_request_body.dart';
import '../data/repos/forgot_password_repo.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepo _forgotPasswordRepo;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  ForgotPasswordCubit(this._forgotPasswordRepo)
    : super(ForgotPasswordState.initial());

  void sendCode() async {
    emit(ForgotPasswordState.sendCodeLoading());
    final response = await _forgotPasswordRepo.sendCode(
      SendCodeRequestBody(email: emailController.text),
    );
    response.when(
      success: (loginResponse) {
        emit(ForgotPasswordState.sendCodeSuccess());
      },
      failure: (error) {
        emit(
          ForgotPasswordState.sendCodeFailure(
            error.apiErrorModel.message ?? '',
          ),
        );
      },
    );
  }
}
