import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/core/di/dependency_injection.dart';
import 'package:mobile/core/routing/routes.dart';
import 'package:mobile/features/home/views/clickable_google_map_view.dart';
import 'package:mobile/features/login/logic/login_cubit.dart';
import 'package:mobile/features/login/views/login_view.dart';
import 'package:mobile/layouts/main/main_view.dart';
import 'package:mobile/features/register/views/register_view.dart';
import '../../features/forgot_password/logic/forgot_password_cubit.dart';
import '../../features/forgot_password/views/enter_code_view.dart';
import '../../features/forgot_password/views/enter_email_view.dart';
import '../../features/forgot_password/views/reset_password_view.dart';
import '../../features/home/logic/scheduled_cubit.dart';
import '../../features/home/views/scheduled_form_view.dart';
import '../../features/login/data/models/login_response.dart';
import '../../features/register/logic/register_cubit.dart';
import '../../layouts/main/cubit/bottom_nav_cubit.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginView(),
          ),
        );
      case Routes.registerView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<RegisterCubit>(),
            child: const RegisterView(),
          ),
        );
      case Routes.enterEmailView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgotPasswordCubit>(),
            child: const EnterEmailView(),
          ),
        );
      case Routes.enterCodeView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgotPasswordCubit>(),
            child: EnterCodeView(email: settings.arguments as String),
          ),
        );
      case Routes.resetPasswordView:
        final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgotPasswordCubit>(),
            child: ResetPasswordView(
              email: args['email'] as String,
              resetToken: args['resetToken'] as String,
            ),
          ),
        );
      case Routes.mainView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<BottomNavCubit>(),
            child: MainView(loginResponse: settings.arguments as LoginResponse),
          ),
        );
      case Routes.scheduledFormView:
        final args = settings.arguments;
        String? token;
        LatLng? startLocation;
        LatLng? endLocation;

        if (args is String) {
          token = args;
        } else if (args is LatLng?) {
          startLocation = args;
          endLocation = args;
        }        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ScheduledCubit>(),
            child: ScheduledFormView(
              token: token,
              startLocation: startLocation,
              endLocation: endLocation,
            ),
          ),
        );
      case Routes.clickableGoogleMap:
        return MaterialPageRoute(
          builder: (_) => const ClickableGoogleMapView(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("no route defined for ${settings.name}")),
          ),
        );
    }
  }
}
