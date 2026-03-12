import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState<T> with _$ForgotPasswordState<T> {
  const factory ForgotPasswordState.initial() = _Initial;

  const factory ForgotPasswordState.sendCodeLoading() = SendCodeLoading;

  const factory ForgotPasswordState.sendCodeSuccess(T data) = SendCodeSuccess<T>;

  const factory ForgotPasswordState.sendCodeFailure(String errMessage) =
      SendCodeFailure;

  const factory ForgotPasswordState.verifyCodeLoading() = VerifyCodeLoading;

  const factory ForgotPasswordState.verifyCodeSuccess(T data) = VerifyCodeSuccess<T>;

  const factory ForgotPasswordState.verifyCodeFailure(String errMessage) =
      VerifyCodeFailure;

  const factory ForgotPasswordState.resetPasswordLoading() =
      ResetPasswordLoading;

  const factory ForgotPasswordState.resetPasswordSuccess(T data) =
      ResetPasswordSuccess<T>;

  const factory ForgotPasswordState.resetPasswordFailure(String errMessage) =
      ResetPasswordFailure;
}
