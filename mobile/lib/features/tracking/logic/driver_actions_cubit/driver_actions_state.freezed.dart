// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_actions_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DriverActionsState<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverActionsState<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverActionsState<$T>()';
}


}

/// @nodoc
class $DriverActionsStateCopyWith<T,$Res>  {
$DriverActionsStateCopyWith(DriverActionsState<T> _, $Res Function(DriverActionsState<T>) __);
}


/// Adds pattern-matching-related methods to [DriverActionsState].
extension DriverActionsStatePatterns<T> on DriverActionsState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial<T> value)?  initial,TResult Function( ActionLoading<T> value)?  actionLoading,TResult Function( ArrivedSuccess<T> value)?  arrivedSuccess,TResult Function( CompletedSuccess<T> value)?  completedSuccess,TResult Function( ActionFailure<T> value)?  actionFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ActionLoading() when actionLoading != null:
return actionLoading(_that);case ArrivedSuccess() when arrivedSuccess != null:
return arrivedSuccess(_that);case CompletedSuccess() when completedSuccess != null:
return completedSuccess(_that);case ActionFailure() when actionFailure != null:
return actionFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial<T> value)  initial,required TResult Function( ActionLoading<T> value)  actionLoading,required TResult Function( ArrivedSuccess<T> value)  arrivedSuccess,required TResult Function( CompletedSuccess<T> value)  completedSuccess,required TResult Function( ActionFailure<T> value)  actionFailure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case ActionLoading():
return actionLoading(_that);case ArrivedSuccess():
return arrivedSuccess(_that);case CompletedSuccess():
return completedSuccess(_that);case ActionFailure():
return actionFailure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial<T> value)?  initial,TResult? Function( ActionLoading<T> value)?  actionLoading,TResult? Function( ArrivedSuccess<T> value)?  arrivedSuccess,TResult? Function( CompletedSuccess<T> value)?  completedSuccess,TResult? Function( ActionFailure<T> value)?  actionFailure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ActionLoading() when actionLoading != null:
return actionLoading(_that);case ArrivedSuccess() when arrivedSuccess != null:
return arrivedSuccess(_that);case CompletedSuccess() when completedSuccess != null:
return completedSuccess(_that);case ActionFailure() when actionFailure != null:
return actionFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  actionLoading,TResult Function( T data)?  arrivedSuccess,TResult Function( T data)?  completedSuccess,TResult Function( String errMessage)?  actionFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ActionLoading() when actionLoading != null:
return actionLoading();case ArrivedSuccess() when arrivedSuccess != null:
return arrivedSuccess(_that.data);case CompletedSuccess() when completedSuccess != null:
return completedSuccess(_that.data);case ActionFailure() when actionFailure != null:
return actionFailure(_that.errMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  actionLoading,required TResult Function( T data)  arrivedSuccess,required TResult Function( T data)  completedSuccess,required TResult Function( String errMessage)  actionFailure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case ActionLoading():
return actionLoading();case ArrivedSuccess():
return arrivedSuccess(_that.data);case CompletedSuccess():
return completedSuccess(_that.data);case ActionFailure():
return actionFailure(_that.errMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  actionLoading,TResult? Function( T data)?  arrivedSuccess,TResult? Function( T data)?  completedSuccess,TResult? Function( String errMessage)?  actionFailure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ActionLoading() when actionLoading != null:
return actionLoading();case ArrivedSuccess() when arrivedSuccess != null:
return arrivedSuccess(_that.data);case CompletedSuccess() when completedSuccess != null:
return completedSuccess(_that.data);case ActionFailure() when actionFailure != null:
return actionFailure(_that.errMessage);case _:
  return null;

}
}

}

/// @nodoc


class _Initial<T> implements DriverActionsState<T> {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverActionsState<$T>.initial()';
}


}




/// @nodoc


class ActionLoading<T> implements DriverActionsState<T> {
  const ActionLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActionLoading<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DriverActionsState<$T>.actionLoading()';
}


}




/// @nodoc


class ArrivedSuccess<T> implements DriverActionsState<T> {
  const ArrivedSuccess(this.data);
  

 final  T data;

/// Create a copy of DriverActionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArrivedSuccessCopyWith<T, ArrivedSuccess<T>> get copyWith => _$ArrivedSuccessCopyWithImpl<T, ArrivedSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArrivedSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'DriverActionsState<$T>.arrivedSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $ArrivedSuccessCopyWith<T,$Res> implements $DriverActionsStateCopyWith<T, $Res> {
  factory $ArrivedSuccessCopyWith(ArrivedSuccess<T> value, $Res Function(ArrivedSuccess<T>) _then) = _$ArrivedSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$ArrivedSuccessCopyWithImpl<T,$Res>
    implements $ArrivedSuccessCopyWith<T, $Res> {
  _$ArrivedSuccessCopyWithImpl(this._self, this._then);

  final ArrivedSuccess<T> _self;
  final $Res Function(ArrivedSuccess<T>) _then;

/// Create a copy of DriverActionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(ArrivedSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class CompletedSuccess<T> implements DriverActionsState<T> {
  const CompletedSuccess(this.data);
  

 final  T data;

/// Create a copy of DriverActionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompletedSuccessCopyWith<T, CompletedSuccess<T>> get copyWith => _$CompletedSuccessCopyWithImpl<T, CompletedSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompletedSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'DriverActionsState<$T>.completedSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $CompletedSuccessCopyWith<T,$Res> implements $DriverActionsStateCopyWith<T, $Res> {
  factory $CompletedSuccessCopyWith(CompletedSuccess<T> value, $Res Function(CompletedSuccess<T>) _then) = _$CompletedSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$CompletedSuccessCopyWithImpl<T,$Res>
    implements $CompletedSuccessCopyWith<T, $Res> {
  _$CompletedSuccessCopyWithImpl(this._self, this._then);

  final CompletedSuccess<T> _self;
  final $Res Function(CompletedSuccess<T>) _then;

/// Create a copy of DriverActionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(CompletedSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class ActionFailure<T> implements DriverActionsState<T> {
  const ActionFailure({required this.errMessage});
  

 final  String errMessage;

/// Create a copy of DriverActionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActionFailureCopyWith<T, ActionFailure<T>> get copyWith => _$ActionFailureCopyWithImpl<T, ActionFailure<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActionFailure<T>&&(identical(other.errMessage, errMessage) || other.errMessage == errMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errMessage);

@override
String toString() {
  return 'DriverActionsState<$T>.actionFailure(errMessage: $errMessage)';
}


}

/// @nodoc
abstract mixin class $ActionFailureCopyWith<T,$Res> implements $DriverActionsStateCopyWith<T, $Res> {
  factory $ActionFailureCopyWith(ActionFailure<T> value, $Res Function(ActionFailure<T>) _then) = _$ActionFailureCopyWithImpl;
@useResult
$Res call({
 String errMessage
});




}
/// @nodoc
class _$ActionFailureCopyWithImpl<T,$Res>
    implements $ActionFailureCopyWith<T, $Res> {
  _$ActionFailureCopyWithImpl(this._self, this._then);

  final ActionFailure<T> _self;
  final $Res Function(ActionFailure<T>) _then;

/// Create a copy of DriverActionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errMessage = null,}) {
  return _then(ActionFailure<T>(
errMessage: null == errMessage ? _self.errMessage : errMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
