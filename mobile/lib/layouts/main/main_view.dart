import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/layouts/main/cubit/bottom_nav_cubit.dart';
import 'package:mobile/layouts/main/widgets/custom_bottom_nav_bar.dart';
import '../../features/home/views/home_view.dart';
import '../../features/notifications/views/notifications_view.dart';
import '../../features/profile/views/profile_view.dart';
import 'navigation/navigation_keys.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: Stack(
            children: List.generate(
              NavigationKeys.navigatorKeys.length,
              (index) => _buildNavigator(index, currentIndex),
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

  Widget _buildNavigator(int index, int currentIndex) {
    return Offstage(
      offstage: currentIndex != index,
      child: Navigator(
        key: NavigationKeys.navigatorKeys[index],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (_) => _getView(index));
        },
      ),
    );
  }

  Widget _getView(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const NotificationsView();
      case 2:
        return const ProfileView();
      default:
        return const HomeView();
    }
  }
}
