import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/login/data/models/login_response.dart';
import 'package:mobile/features/requests/logic/emergency_requests_cubit.dart';
import 'package:mobile/layouts/main/cubit/bottom_nav_cubit.dart';
import 'package:mobile/layouts/main/widgets/custom_bottom_nav_bar.dart';
import '../../core/di/dependency_injection.dart';
import '../../features/home/logic/emergency_cubit.dart';
import '../../features/home/views/home_view.dart';
import '../../features/requests/logic/scheduled_requests_cubit.dart';
import '../../features/requests/views/requests_view.dart';
import '../../features/profile/views/profile_view.dart';
import 'navigation/navigation_keys.dart';

class MainView extends StatelessWidget {
  final LoginResponse loginResponse;

  const MainView({super.key, required this.loginResponse});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: Stack(
            children: List.generate(
              NavigationKeys.navigatorKeys.length,
              (index) => _buildNavigator(context, index, currentIndex),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: currentIndex,
            onTap: (index) {
              if (index == currentIndex) {
                NavigationKeys.navigatorKeys[index].currentState!.popUntil(
                  (route) => route.isFirst,
                );
              } else {
                context.read<BottomNavCubit>().changeIndex(index);
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildNavigator(BuildContext context, int index, int currentIndex) {
    return Offstage(
      offstage: currentIndex != index,
      child: Navigator(
        key: NavigationKeys.navigatorKeys[index],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (_) => _getView(context, index));
        },
      ),
    );
  }

  Widget _getView(BuildContext context, int index) {
    switch (index) {
      case 0:
        return BlocProvider(
          create: (context) => getIt<EmergencyCubit>(),
          child: HomeView(token: loginResponse.userData?.token ?? ''),
        );
      case 1:
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<EmergencyRequestsCubit>()),
            BlocProvider(create: (context) => getIt<ScheduledRequestsCubit>()),
          ],
          child: RequestsView(token: loginResponse.userData?.token ?? ''),
        );
      case 2:
        return const ProfileView();
      default:
        return HomeView(token: loginResponse.userData?.token ?? '');
    }
  }
}
