import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/di/dependency_injection.dart';
import 'package:mobile/core/routing/routes.dart';
import 'package:mobile/features/home/views/home_view.dart';
import 'package:mobile/features/login/logic/login_cubit.dart';
import 'package:mobile/features/login/views/login_view.dart';
import 'package:mobile/features/register/views/register_view.dart';
import '../../features/forgot_password/logic/forgot_password_cubit.dart';
import '../../features/forgot_password/views/enter_code_view.dart';
import '../../features/forgot_password/views/enter_email_view.dart';
import '../../features/forgot_password/views/reset_password_view.dart';
import '../../features/register/logic/register_cubit.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

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
        return MaterialPageRoute(builder: (_) => const EnterCodeView());
      case Routes.resetPasswordView:
        return MaterialPageRoute(builder: (_) => const ResetPasswordView());
      case Routes.homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());
      default:
        return MaterialPageRoute(
          builder: (_) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text("no route defined for ${settings.name}"),
              ),
            ),
          ),
        );
    }
  }
}
