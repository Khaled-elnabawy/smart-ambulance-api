import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_state.freezed.dart';

@freezed
class RatingState<T> with _$RatingState<T> {
  const factory RatingState.initial() = _Initial;
  const factory RatingState.loading() = Loading;
  const factory RatingState.success(T data) = Success<T>;
  const factory RatingState.failure({required String errMessage}) = Failure;
}
