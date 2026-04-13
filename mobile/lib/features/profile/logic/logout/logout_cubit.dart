import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/networking/api_result.dart';
import 'package:mobile/features/profile/logic/logout/logout_state.dart';
import '../../data/repos/profile_repo.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final ProfileRepo logoutRepo;

  LogoutCubit(this.logoutRepo) : super(LogoutState.initial());

  void emitLogoutState({required String token}) async {
    emit(LogoutState.loading());
    final response = await logoutRepo.logout(token);
    response.when(
      success: (data) {
        emit(LogoutState.success(data));
      },
      failure: (error) {
        emit(
          LogoutState.failure(errMessage: error.apiErrorModel.message ?? ''),
        );
      },
    );
  }
}
