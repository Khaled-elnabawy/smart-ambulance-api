import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/colors.dart';
import '../../logic/emergency_cubit.dart';
import '../../logic/home_state.dart';

class EmergencyBlocListener extends StatelessWidget {
  const EmergencyBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmergencyCubit, HomeState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Failure,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            // show loading
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: ColorsManager.red),
              ),
            );
          },

        );
      },
    );
  }
}
