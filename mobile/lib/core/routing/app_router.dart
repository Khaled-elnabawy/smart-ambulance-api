import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/di/dependency_injection.dart';
import 'package:mobile/core/routing/routes.dart';
import 'package:mobile/features/login/logic/login_cubit.dart';
import 'package:mobile/features/login/views/login_view.dart';

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
