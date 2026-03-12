// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForgotPasswordState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState()';
}


}

/// @nodoc
class $ForgotPasswordStateCopyWith<$Res>  {
$ForgotPasswordStateCopyWith(ForgotPasswordState _, $Res Function(ForgotPasswordState) __);
}


/// Adds pattern-matching-related methods to [ForgotPasswordState].
extension ForgotPasswordStatePatterns on ForgotPasswordState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( SendCodeLoading value)?  sendCodeLoading,TResult Function( SendCodeSuccess value)?  sendCodeSuccess,TResult Function( SendCodeFailure value)?  sendCodeFailure,TResult Function( VerifyCodeLoading value)?  verifyCodeLoading,TResult Function( VerifyCodeSuccess value)?  verifyCodeSuccess,TResult Function( VerifyCodeFailure value)?  verifyCodeFailure,TResult Function( ResetPasswordLoading value)?  resetPasswordLoading,TResult Function( ResetPasswordSuccess value)?  resetPasswordSuccess,TResult Function( ResetPasswordFailure value)?  resetPasswordFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case SendCodeLoading() when sendCodeLoading != null:
return sendCodeLoading(_that);case SendCodeSuccess() when sendCodeSuccess != null:
return sendCodeSuccess(_that);case SendCodeFailure() when sendCodeFailure != null:
return sendCodeFailure(_that);case VerifyCodeLoading() when verifyCodeLoading != null:
return verifyCodeLoading(_that);case VerifyCodeSuccess() when verifyCodeSuccess != null:
return verifyCodeSuccess(_that);case VerifyCodeFailure() when verifyCodeFailure != null:
return verifyCodeFailure(_that);case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading(_that);case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that);case ResetPasswordFailure() when resetPasswordFailure != null:
return resetPasswordFailure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( SendCodeLoading value)  sendCodeLoading,required TResult Function( SendCodeSuccess value)  sendCodeSuccess,required TResult Function( SendCodeFailure value)  sendCodeFailure,required TResult Function( VerifyCodeLoading value)  verifyCodeLoading,required TResult Function( VerifyCodeSuccess value)  verifyCodeSuccess,required TResult Function( VerifyCodeFailure value)  verifyCodeFailure,required TResult Function( ResetPasswordLoading value)  resetPasswordLoading,required TResult Function( ResetPasswordSuccess value)  resetPasswordSuccess,required TResult Function( ResetPasswordFailure value)  resetPasswordFailure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case SendCodeLoading():
return sendCodeLoading(_that);case SendCodeSuccess():
return sendCodeSuccess(_that);case SendCodeFailure():
return sendCodeFailure(_that);case VerifyCodeLoading():
return verifyCodeLoading(_that);case VerifyCodeSuccess():
return verifyCodeSuccess(_that);case VerifyCodeFailure():
return verifyCodeFailure(_that);case ResetPasswordLoading():
return resetPasswordLoading(_that);case ResetPasswordSuccess():
return resetPasswordSuccess(_that);case ResetPasswordFailure():
return resetPasswordFailure(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( SendCodeLoading value)?  sendCodeLoading,TResult? Function( SendCodeSuccess value)?  sendCodeSuccess,TResult? Function( SendCodeFailure value)?  sendCodeFailure,TResult? Function( VerifyCodeLoading value)?  verifyCodeLoading,TResult? Function( VerifyCodeSuccess value)?  verifyCodeSuccess,TResult? Function( VerifyCodeFailure value)?  verifyCodeFailure,TResult? Function( ResetPasswordLoading value)?  resetPasswordLoading,TResult? Function( ResetPasswordSuccess value)?  resetPasswordSuccess,TResult? Function( ResetPasswordFailure value)?  resetPasswordFailure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case SendCodeLoading() when sendCodeLoading != null:
return sendCodeLoading(_that);case SendCodeSuccess() when sendCodeSuccess != null:
return sendCodeSuccess(_that);case SendCodeFailure() when sendCodeFailure != null:
return sendCodeFailure(_that);case VerifyCodeLoading() when verifyCodeLoading != null:
return verifyCodeLoading(_that);case VerifyCodeSuccess() when verifyCodeSuccess != null:
return verifyCodeSuccess(_that);case VerifyCodeFailure() when verifyCodeFailure != null:
return verifyCodeFailure(_that);case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading(_that);case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that);case ResetPasswordFailure() when resetPasswordFailure != null:
return resetPasswordFailure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  sendCodeLoading,TResult Function()?  sendCodeSuccess,TResult Function( String errMessage)?  sendCodeFailure,TResult Function()?  verifyCodeLoading,TResult Function()?  verifyCodeSuccess,TResult Function( String errMessage)?  verifyCodeFailure,TResult Function()?  resetPasswordLoading,TResult Function()?  resetPasswordSuccess,TResult Function( String errMessage)?  resetPasswordFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case SendCodeLoading() when sendCodeLoading != null:
return sendCodeLoading();case SendCodeSuccess() when sendCodeSuccess != null:
return sendCodeSuccess();case SendCodeFailure() when sendCodeFailure != null:
return sendCodeFailure(_that.errMessage);case VerifyCodeLoading() when verifyCodeLoading != null:
return verifyCodeLoading();case VerifyCodeSuccess() when verifyCodeSuccess != null:
return verifyCodeSuccess();case VerifyCodeFailure() when verifyCodeFailure != null:
return verifyCodeFailure(_that.errMessage);case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading();case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess();case ResetPasswordFailure() when resetPasswordFailure != null:
return resetPasswordFailure(_that.errMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  sendCodeLoading,required TResult Function()  sendCodeSuccess,required TResult Function( String errMessage)  sendCodeFailure,required TResult Function()  verifyCodeLoading,required TResult Function()  verifyCodeSuccess,required TResult Function( String errMessage)  verifyCodeFailure,required TResult Function()  resetPasswordLoading,required TResult Function()  resetPasswordSuccess,required TResult Function( String errMessage)  resetPasswordFailure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case SendCodeLoading():
return sendCodeLoading();case SendCodeSuccess():
return sendCodeSuccess();case SendCodeFailure():
return sendCodeFailure(_that.errMessage);case VerifyCodeLoading():
return verifyCodeLoading();case VerifyCodeSuccess():
return verifyCodeSuccess();case VerifyCodeFailure():
return verifyCodeFailure(_that.errMessage);case ResetPasswordLoading():
return resetPasswordLoading();case ResetPasswordSuccess():
return resetPasswordSuccess();case ResetPasswordFailure():
return resetPasswordFailure(_that.errMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  sendCodeLoading,TResult? Function()?  sendCodeSuccess,TResult? Function( String errMessage)?  sendCodeFailure,TResult? Function()?  verifyCodeLoading,TResult? Function()?  verifyCodeSuccess,TResult? Function( String errMessage)?  verifyCodeFailure,TResult? Function()?  resetPasswordLoading,TResult? Function()?  resetPasswordSuccess,TResult? Function( String errMessage)?  resetPasswordFailure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case SendCodeLoading() when sendCodeLoading != null:
return sendCodeLoading();case SendCodeSuccess() when sendCodeSuccess != null:
return sendCodeSuccess();case SendCodeFailure() when sendCodeFailure != null:
return sendCodeFailure(_that.errMessage);case VerifyCodeLoading() when verifyCodeLoading != null:
return verifyCodeLoading();case VerifyCodeSuccess() when verifyCodeSuccess != null:
return verifyCodeSuccess();case VerifyCodeFailure() when verifyCodeFailure != null:
return verifyCodeFailure(_that.errMessage);case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading();case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess();case ResetPasswordFailure() when resetPasswordFailure != null:
return resetPasswordFailure(_that.errMessage);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ForgotPasswordState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.initial()';
}


}




/// @nodoc


class SendCodeLoading implements ForgotPasswordState {
  const SendCodeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendCodeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.sendCodeLoading()';
}


}




/// @nodoc


class SendCodeSuccess implements ForgotPasswordState {
  const SendCodeSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendCodeSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.sendCodeSuccess()';
}


}




/// @nodoc


class SendCodeFailure implements ForgotPasswordState {
  const SendCodeFailure(this.errMessage);
  

 final  String errMessage;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendCodeFailureCopyWith<SendCodeFailure> get copyWith => _$SendCodeFailureCopyWithImpl<SendCodeFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendCodeFailure&&(identical(other.errMessage, errMessage) || other.errMessage == errMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errMessage);

@override
String toString() {
  return 'ForgotPasswordState.sendCodeFailure(errMessage: $errMessage)';
}


}

/// @nodoc
abstract mixin class $SendCodeFailureCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $SendCodeFailureCopyWith(SendCodeFailure value, $Res Function(SendCodeFailure) _then) = _$SendCodeFailureCopyWithImpl;
@useResult
$Res call({
 String errMessage
});




}
/// @nodoc
class _$SendCodeFailureCopyWithImpl<$Res>
    implements $SendCodeFailureCopyWith<$Res> {
  _$SendCodeFailureCopyWithImpl(this._self, this._then);

  final SendCodeFailure _self;
  final $Res Function(SendCodeFailure) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errMessage = null,}) {
  return _then(SendCodeFailure(
null == errMessage ? _self.errMessage : errMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VerifyCodeLoading implements ForgotPasswordState {
  const VerifyCodeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyCodeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.verifyCodeLoading()';
}


}




/// @nodoc


class VerifyCodeSuccess implements ForgotPasswordState {
  const VerifyCodeSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyCodeSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.verifyCodeSuccess()';
}


}




/// @nodoc


class VerifyCodeFailure implements ForgotPasswordState {
  const VerifyCodeFailure(this.errMessage);
  

 final  String errMessage;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyCodeFailureCopyWith<VerifyCodeFailure> get copyWith => _$VerifyCodeFailureCopyWithImpl<VerifyCodeFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyCodeFailure&&(identical(other.errMessage, errMessage) || other.errMessage == errMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errMessage);

@override
String toString() {
  return 'ForgotPasswordState.verifyCodeFailure(errMessage: $errMessage)';
}


}

/// @nodoc
abstract mixin class $VerifyCodeFailureCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $VerifyCodeFailureCopyWith(VerifyCodeFailure value, $Res Function(VerifyCodeFailure) _then) = _$VerifyCodeFailureCopyWithImpl;
@useResult
$Res call({
 String errMessage
});




}
/// @nodoc
class _$VerifyCodeFailureCopyWithImpl<$Res>
    implements $VerifyCodeFailureCopyWith<$Res> {
  _$VerifyCodeFailureCopyWithImpl(this._self, this._then);

  final VerifyCodeFailure _self;
  final $Res Function(VerifyCodeFailure) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errMessage = null,}) {
  return _then(VerifyCodeFailure(
null == errMessage ? _self.errMessage : errMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ResetPasswordLoading implements ForgotPasswordState {
  const ResetPasswordLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.resetPasswordLoading()';
}


}




/// @nodoc


class ResetPasswordSuccess implements ForgotPasswordState {
  const ResetPasswordSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState.resetPasswordSuccess()';
}


}




/// @nodoc


class ResetPasswordFailure implements ForgotPasswordState {
  const ResetPasswordFailure(this.errMessage);
  

 final  String errMessage;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordFailureCopyWith<ResetPasswordFailure> get copyWith => _$ResetPasswordFailureCopyWithImpl<ResetPasswordFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordFailure&&(identical(other.errMessage, errMessage) || other.errMessage == errMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errMessage);

@override
String toString() {
  return 'ForgotPasswordState.resetPasswordFailure(errMessage: $errMessage)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordFailureCopyWith<$Res> implements $ForgotPasswordStateCopyWith<$Res> {
  factory $ResetPasswordFailureCopyWith(ResetPasswordFailure value, $Res Function(ResetPasswordFailure) _then) = _$ResetPasswordFailureCopyWithImpl;
@useResult
$Res call({
 String errMessage
});




}
/// @nodoc
class _$ResetPasswordFailureCopyWithImpl<$Res>
    implements $ResetPasswordFailureCopyWith<$Res> {
  _$ResetPasswordFailureCopyWithImpl(this._self, this._then);

  final ResetPasswordFailure _self;
  final $Res Function(ResetPasswordFailure) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errMessage = null,}) {
  return _then(ResetPasswordFailure(
null == errMessage ? _self.errMessage : errMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
