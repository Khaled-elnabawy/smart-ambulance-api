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
mixin _$ForgotPasswordState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState<$T>()';
}


}

/// @nodoc
class $ForgotPasswordStateCopyWith<T,$Res>  {
$ForgotPasswordStateCopyWith(ForgotPasswordState<T> _, $Res Function(ForgotPasswordState<T>) __);
}


/// Adds pattern-matching-related methods to [ForgotPasswordState].
extension ForgotPasswordStatePatterns<T> on ForgotPasswordState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial<T> value)?  initial,TResult Function( SendCodeLoading<T> value)?  sendCodeLoading,TResult Function( SendCodeSuccess<T> value)?  sendCodeSuccess,TResult Function( SendCodeFailure<T> value)?  sendCodeFailure,TResult Function( VerifyCodeLoading<T> value)?  verifyCodeLoading,TResult Function( VerifyCodeSuccess<T> value)?  verifyCodeSuccess,TResult Function( VerifyCodeFailure<T> value)?  verifyCodeFailure,TResult Function( ResetPasswordLoading<T> value)?  resetPasswordLoading,TResult Function( ResetPasswordSuccess<T> value)?  resetPasswordSuccess,TResult Function( ResetPasswordFailure<T> value)?  resetPasswordFailure,required TResult orElse(),}){
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial<T> value)  initial,required TResult Function( SendCodeLoading<T> value)  sendCodeLoading,required TResult Function( SendCodeSuccess<T> value)  sendCodeSuccess,required TResult Function( SendCodeFailure<T> value)  sendCodeFailure,required TResult Function( VerifyCodeLoading<T> value)  verifyCodeLoading,required TResult Function( VerifyCodeSuccess<T> value)  verifyCodeSuccess,required TResult Function( VerifyCodeFailure<T> value)  verifyCodeFailure,required TResult Function( ResetPasswordLoading<T> value)  resetPasswordLoading,required TResult Function( ResetPasswordSuccess<T> value)  resetPasswordSuccess,required TResult Function( ResetPasswordFailure<T> value)  resetPasswordFailure,}){
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial<T> value)?  initial,TResult? Function( SendCodeLoading<T> value)?  sendCodeLoading,TResult? Function( SendCodeSuccess<T> value)?  sendCodeSuccess,TResult? Function( SendCodeFailure<T> value)?  sendCodeFailure,TResult? Function( VerifyCodeLoading<T> value)?  verifyCodeLoading,TResult? Function( VerifyCodeSuccess<T> value)?  verifyCodeSuccess,TResult? Function( VerifyCodeFailure<T> value)?  verifyCodeFailure,TResult? Function( ResetPasswordLoading<T> value)?  resetPasswordLoading,TResult? Function( ResetPasswordSuccess<T> value)?  resetPasswordSuccess,TResult? Function( ResetPasswordFailure<T> value)?  resetPasswordFailure,}){
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  sendCodeLoading,TResult Function( T data)?  sendCodeSuccess,TResult Function( String errMessage)?  sendCodeFailure,TResult Function()?  verifyCodeLoading,TResult Function( T data)?  verifyCodeSuccess,TResult Function( String errMessage)?  verifyCodeFailure,TResult Function()?  resetPasswordLoading,TResult Function( T data)?  resetPasswordSuccess,TResult Function( String errMessage)?  resetPasswordFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case SendCodeLoading() when sendCodeLoading != null:
return sendCodeLoading();case SendCodeSuccess() when sendCodeSuccess != null:
return sendCodeSuccess(_that.data);case SendCodeFailure() when sendCodeFailure != null:
return sendCodeFailure(_that.errMessage);case VerifyCodeLoading() when verifyCodeLoading != null:
return verifyCodeLoading();case VerifyCodeSuccess() when verifyCodeSuccess != null:
return verifyCodeSuccess(_that.data);case VerifyCodeFailure() when verifyCodeFailure != null:
return verifyCodeFailure(_that.errMessage);case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading();case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that.data);case ResetPasswordFailure() when resetPasswordFailure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  sendCodeLoading,required TResult Function( T data)  sendCodeSuccess,required TResult Function( String errMessage)  sendCodeFailure,required TResult Function()  verifyCodeLoading,required TResult Function( T data)  verifyCodeSuccess,required TResult Function( String errMessage)  verifyCodeFailure,required TResult Function()  resetPasswordLoading,required TResult Function( T data)  resetPasswordSuccess,required TResult Function( String errMessage)  resetPasswordFailure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case SendCodeLoading():
return sendCodeLoading();case SendCodeSuccess():
return sendCodeSuccess(_that.data);case SendCodeFailure():
return sendCodeFailure(_that.errMessage);case VerifyCodeLoading():
return verifyCodeLoading();case VerifyCodeSuccess():
return verifyCodeSuccess(_that.data);case VerifyCodeFailure():
return verifyCodeFailure(_that.errMessage);case ResetPasswordLoading():
return resetPasswordLoading();case ResetPasswordSuccess():
return resetPasswordSuccess(_that.data);case ResetPasswordFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  sendCodeLoading,TResult? Function( T data)?  sendCodeSuccess,TResult? Function( String errMessage)?  sendCodeFailure,TResult? Function()?  verifyCodeLoading,TResult? Function( T data)?  verifyCodeSuccess,TResult? Function( String errMessage)?  verifyCodeFailure,TResult? Function()?  resetPasswordLoading,TResult? Function( T data)?  resetPasswordSuccess,TResult? Function( String errMessage)?  resetPasswordFailure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case SendCodeLoading() when sendCodeLoading != null:
return sendCodeLoading();case SendCodeSuccess() when sendCodeSuccess != null:
return sendCodeSuccess(_that.data);case SendCodeFailure() when sendCodeFailure != null:
return sendCodeFailure(_that.errMessage);case VerifyCodeLoading() when verifyCodeLoading != null:
return verifyCodeLoading();case VerifyCodeSuccess() when verifyCodeSuccess != null:
return verifyCodeSuccess(_that.data);case VerifyCodeFailure() when verifyCodeFailure != null:
return verifyCodeFailure(_that.errMessage);case ResetPasswordLoading() when resetPasswordLoading != null:
return resetPasswordLoading();case ResetPasswordSuccess() when resetPasswordSuccess != null:
return resetPasswordSuccess(_that.data);case ResetPasswordFailure() when resetPasswordFailure != null:
return resetPasswordFailure(_that.errMessage);case _:
  return null;

}
}

}

/// @nodoc


class _Initial<T> implements ForgotPasswordState<T> {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState<$T>.initial()';
}


}




/// @nodoc


class SendCodeLoading<T> implements ForgotPasswordState<T> {
  const SendCodeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendCodeLoading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState<$T>.sendCodeLoading()';
}


}




/// @nodoc


class SendCodeSuccess<T> implements ForgotPasswordState<T> {
  const SendCodeSuccess(this.data);
  

 final  T data;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendCodeSuccessCopyWith<T, SendCodeSuccess<T>> get copyWith => _$SendCodeSuccessCopyWithImpl<T, SendCodeSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendCodeSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ForgotPasswordState<$T>.sendCodeSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $SendCodeSuccessCopyWith<T,$Res> implements $ForgotPasswordStateCopyWith<T, $Res> {
  factory $SendCodeSuccessCopyWith(SendCodeSuccess<T> value, $Res Function(SendCodeSuccess<T>) _then) = _$SendCodeSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$SendCodeSuccessCopyWithImpl<T,$Res>
    implements $SendCodeSuccessCopyWith<T, $Res> {
  _$SendCodeSuccessCopyWithImpl(this._self, this._then);

  final SendCodeSuccess<T> _self;
  final $Res Function(SendCodeSuccess<T>) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(SendCodeSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class SendCodeFailure<T> implements ForgotPasswordState<T> {
  const SendCodeFailure(this.errMessage);
  

 final  String errMessage;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendCodeFailureCopyWith<T, SendCodeFailure<T>> get copyWith => _$SendCodeFailureCopyWithImpl<T, SendCodeFailure<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendCodeFailure<T>&&(identical(other.errMessage, errMessage) || other.errMessage == errMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errMessage);

@override
String toString() {
  return 'ForgotPasswordState<$T>.sendCodeFailure(errMessage: $errMessage)';
}


}

/// @nodoc
abstract mixin class $SendCodeFailureCopyWith<T,$Res> implements $ForgotPasswordStateCopyWith<T, $Res> {
  factory $SendCodeFailureCopyWith(SendCodeFailure<T> value, $Res Function(SendCodeFailure<T>) _then) = _$SendCodeFailureCopyWithImpl;
@useResult
$Res call({
 String errMessage
});




}
/// @nodoc
class _$SendCodeFailureCopyWithImpl<T,$Res>
    implements $SendCodeFailureCopyWith<T, $Res> {
  _$SendCodeFailureCopyWithImpl(this._self, this._then);

  final SendCodeFailure<T> _self;
  final $Res Function(SendCodeFailure<T>) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errMessage = null,}) {
  return _then(SendCodeFailure<T>(
null == errMessage ? _self.errMessage : errMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VerifyCodeLoading<T> implements ForgotPasswordState<T> {
  const VerifyCodeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyCodeLoading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState<$T>.verifyCodeLoading()';
}


}




/// @nodoc


class VerifyCodeSuccess<T> implements ForgotPasswordState<T> {
  const VerifyCodeSuccess(this.data);
  

 final  T data;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyCodeSuccessCopyWith<T, VerifyCodeSuccess<T>> get copyWith => _$VerifyCodeSuccessCopyWithImpl<T, VerifyCodeSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyCodeSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ForgotPasswordState<$T>.verifyCodeSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $VerifyCodeSuccessCopyWith<T,$Res> implements $ForgotPasswordStateCopyWith<T, $Res> {
  factory $VerifyCodeSuccessCopyWith(VerifyCodeSuccess<T> value, $Res Function(VerifyCodeSuccess<T>) _then) = _$VerifyCodeSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$VerifyCodeSuccessCopyWithImpl<T,$Res>
    implements $VerifyCodeSuccessCopyWith<T, $Res> {
  _$VerifyCodeSuccessCopyWithImpl(this._self, this._then);

  final VerifyCodeSuccess<T> _self;
  final $Res Function(VerifyCodeSuccess<T>) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(VerifyCodeSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class VerifyCodeFailure<T> implements ForgotPasswordState<T> {
  const VerifyCodeFailure(this.errMessage);
  

 final  String errMessage;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyCodeFailureCopyWith<T, VerifyCodeFailure<T>> get copyWith => _$VerifyCodeFailureCopyWithImpl<T, VerifyCodeFailure<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyCodeFailure<T>&&(identical(other.errMessage, errMessage) || other.errMessage == errMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errMessage);

@override
String toString() {
  return 'ForgotPasswordState<$T>.verifyCodeFailure(errMessage: $errMessage)';
}


}

/// @nodoc
abstract mixin class $VerifyCodeFailureCopyWith<T,$Res> implements $ForgotPasswordStateCopyWith<T, $Res> {
  factory $VerifyCodeFailureCopyWith(VerifyCodeFailure<T> value, $Res Function(VerifyCodeFailure<T>) _then) = _$VerifyCodeFailureCopyWithImpl;
@useResult
$Res call({
 String errMessage
});




}
/// @nodoc
class _$VerifyCodeFailureCopyWithImpl<T,$Res>
    implements $VerifyCodeFailureCopyWith<T, $Res> {
  _$VerifyCodeFailureCopyWithImpl(this._self, this._then);

  final VerifyCodeFailure<T> _self;
  final $Res Function(VerifyCodeFailure<T>) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errMessage = null,}) {
  return _then(VerifyCodeFailure<T>(
null == errMessage ? _self.errMessage : errMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ResetPasswordLoading<T> implements ForgotPasswordState<T> {
  const ResetPasswordLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordLoading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ForgotPasswordState<$T>.resetPasswordLoading()';
}


}




/// @nodoc


class ResetPasswordSuccess<T> implements ForgotPasswordState<T> {
  const ResetPasswordSuccess(this.data);
  

 final  T data;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordSuccessCopyWith<T, ResetPasswordSuccess<T>> get copyWith => _$ResetPasswordSuccessCopyWithImpl<T, ResetPasswordSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ForgotPasswordState<$T>.resetPasswordSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordSuccessCopyWith<T,$Res> implements $ForgotPasswordStateCopyWith<T, $Res> {
  factory $ResetPasswordSuccessCopyWith(ResetPasswordSuccess<T> value, $Res Function(ResetPasswordSuccess<T>) _then) = _$ResetPasswordSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$ResetPasswordSuccessCopyWithImpl<T,$Res>
    implements $ResetPasswordSuccessCopyWith<T, $Res> {
  _$ResetPasswordSuccessCopyWithImpl(this._self, this._then);

  final ResetPasswordSuccess<T> _self;
  final $Res Function(ResetPasswordSuccess<T>) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(ResetPasswordSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class ResetPasswordFailure<T> implements ForgotPasswordState<T> {
  const ResetPasswordFailure(this.errMessage);
  

 final  String errMessage;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordFailureCopyWith<T, ResetPasswordFailure<T>> get copyWith => _$ResetPasswordFailureCopyWithImpl<T, ResetPasswordFailure<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordFailure<T>&&(identical(other.errMessage, errMessage) || other.errMessage == errMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errMessage);

@override
String toString() {
  return 'ForgotPasswordState<$T>.resetPasswordFailure(errMessage: $errMessage)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordFailureCopyWith<T,$Res> implements $ForgotPasswordStateCopyWith<T, $Res> {
  factory $ResetPasswordFailureCopyWith(ResetPasswordFailure<T> value, $Res Function(ResetPasswordFailure<T>) _then) = _$ResetPasswordFailureCopyWithImpl;
@useResult
$Res call({
 String errMessage
});




}
/// @nodoc
class _$ResetPasswordFailureCopyWithImpl<T,$Res>
    implements $ResetPasswordFailureCopyWith<T, $Res> {
  _$ResetPasswordFailureCopyWithImpl(this._self, this._then);

  final ResetPasswordFailure<T> _self;
  final $Res Function(ResetPasswordFailure<T>) _then;

/// Create a copy of ForgotPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errMessage = null,}) {
  return _then(ResetPasswordFailure<T>(
null == errMessage ? _self.errMessage : errMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
