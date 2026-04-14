import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_state.freezed.dart';

@freezed
class EditProfileState<T> with _$EditProfileState<T> {
  const factory EditProfileState.initial() = _Initial;

  const factory EditProfileState.loading() = Loading;

  const factory EditProfileState.success(T data) = Success<T>;

  const factory EditProfileState.failure({required String errMessage}) = Failure;
}
