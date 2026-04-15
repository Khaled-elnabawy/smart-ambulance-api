import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/networking/api_result.dart';
import 'package:mobile/features/profile/data/models/edit_profile/edit_profile_request_model.dart';
import 'package:mobile/features/profile/logic/edit_profile/edit_profile_state.dart';
import '../../data/repos/profile_repo.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final ProfileRepo profileRepo;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  EditProfileCubit(this.profileRepo) : super(EditProfileState.initial());

  void emitEditProfileState({required String token}) async {
    emit(EditProfileState.loading());
    final response = await profileRepo.editProfile(
      token,
      EditProfileRequestModel(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
      ),
    );
    response.when(
      success: (data) {
        emit(EditProfileState.success(data));
      },
      failure: (error) {
        emit(
          EditProfileState.failure(
            errMessage: error.apiErrorModel.message ?? '',
          ),
        );
      },
    );
  }
}
