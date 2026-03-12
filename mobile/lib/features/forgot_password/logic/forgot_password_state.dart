import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = _Initial;

  const factory ForgotPasswordState.sendCodeLoading() = SendCodeLoading;

  const factory ForgotPasswordState.sendCodeSuccess() = SendCodeSuccess;

  const factory ForgotPasswordState.sendCodeFailure(String errMessage) =
      SendCodeFailure;

  const factory ForgotPasswordState.verifyCodeLoading() = VerifyCodeLoading;

  const factory ForgotPasswordState.verifyCodeSuccess() = VerifyCodeSuccess;

  const factory ForgotPasswordState.verifyCodeFailure(String errMessage) =
      VerifyCodeFailure;

  const factory ForgotPasswordState.resetPasswordLoading() =
      ResetPasswordLoading;

  const factory ForgotPasswordState.resetPasswordSuccess() =
      ResetPasswordSuccess;

  const factory ForgotPasswordState.resetPasswordFailure(String errMessage) =
      ResetPasswordFailure;
}
