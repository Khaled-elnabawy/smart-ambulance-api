import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/register/logic/register_state.dart';
import '../../../core/networking/api_result.dart';
import '../data/models/register_request_body.dart';
import '../data/repos/register_repo.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo;

  RegisterCubit(this._registerRepo) : super(RegisterState.initial());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void emitRegisterState() async {
    emit(RegisterState.loading());
    final response = await _registerRepo.register(
      RegisterRequestBody(
        name: nameController.text,
        phone: phoneController.text,
        nationalId: nationalIdController.text,
        email: emailController.text,
        password: passwordController.text,
        passwordConfirmation: passwordConfirmationController.text,
      ),
    );
    response.when(
      success: (registerResponse) {
        emit(RegisterState.success(registerResponse));
      },
      failure: (error) {
        emit(
          RegisterState.failure(errMessage: error.apiErrorModel.message ?? ''),
        );
      },
    );
  }
}
