import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/networking/api_result.dart';
import '../data/models/reset_password_models/reset_password_request_body.dart';
import '../data/models/send_code_models/send_code_request_body.dart';
import '../data/models/verify_code_models/verify_code_request_body.dart';
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
      success: (sendCodeResponse) {
        emit(ForgotPasswordState.sendCodeSuccess(sendCodeResponse));
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

  void verifyCode(String email) async {
    emit(ForgotPasswordState.verifyCodeLoading());
    final response = await _forgotPasswordRepo.verifyCode(
      VerifyCodeRequestBody(email: email, code: codeController.text),
    );
    response.when(
      success: (verifyCodeResponse) {
        emit(ForgotPasswordState.verifyCodeSuccess(verifyCodeResponse));
      },
      failure: (error) {
        emit(
          ForgotPasswordState.verifyCodeFailure(
            error.apiErrorModel.message ?? '',
          ),
        );
      },
    );
  }

  void resetPassword({required String email,required String resetToken}) async {
    emit(ForgotPasswordState.resetPasswordLoading());
    final response = await _forgotPasswordRepo.resetPassword(
      ResetPasswordRequestBody(
        email: email,
        resetToken: resetToken,
        password: newPasswordController.text,
        confirmPassword: confirmNewPasswordController.text,
      ),
    );
    response.when(
      success: (resetPasswordResponse) {
        emit(ForgotPasswordState.resetPasswordSuccess(resetPasswordResponse));
      },
      failure: (error) {
        emit(
          ForgotPasswordState.resetPasswordFailure(
            error.apiErrorModel.message ?? '',
          ),
        );
      },
    );
  }
}
