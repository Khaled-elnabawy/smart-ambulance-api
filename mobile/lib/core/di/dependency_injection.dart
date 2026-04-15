import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile/features/forgot_password/data/repos/forgot_password_repo.dart';
import 'package:mobile/features/forgot_password/logic/forgot_password_cubit.dart';
import 'package:mobile/features/home/logic/scheduled_cubit.dart';
import 'package:mobile/features/profile/logic/logout/logout_cubit.dart';
import 'package:mobile/layouts/main/cubit/bottom_nav_cubit.dart';
import '../../features/home/data/repos/home_repo.dart';
import '../../features/home/logic/emergency_cubit.dart';
import '../../features/login/data/repos/login_repo.dart';
import '../../features/login/logic/login_cubit.dart';
import '../../features/profile/data/repos/profile_repo.dart';
import '../../features/profile/logic/edit_profile/edit_profile_cubit.dart';
import '../../features/register/data/repos/register_repo.dart';
import '../../features/register/logic/register_cubit.dart';
import '../../features/requests/data/repo/requests_repo.dart';
import '../../features/requests/logic/cancel_cubit/cancel_cubit.dart';
import '../../features/requests/logic/requests_cubits/emergency_requests_cubit.dart';
import '../../features/requests/logic/requests_cubits/scheduled_requests_cubit.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';
import '../services/directions/directions_api_service.dart';
import '../services/directions/directions_service.dart';
import '../services/location/location_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio
  Dio dio = DioFactory.getDio();

  // ApiService instance
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // DirectionsApiService instance
  getIt.registerLazySingleton<DirectionsApiService>(
    () => DirectionsApiService(dio),
  );
  // DirectionsService instance
  getIt.registerLazySingleton<DirectionsService>(
    () => DirectionsService(getIt()),
  );

  // Login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // register
  getIt.registerLazySingleton<RegisterRepo>(() => RegisterRepo(getIt()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));

  // forgot password
  getIt.registerLazySingleton<ForgotPasswordRepo>(
    () => ForgotPasswordRepo(getIt()),
  );
  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(getIt()),
  );

  // bottom navigation cubit
  getIt.registerFactory<BottomNavCubit>(() => BottomNavCubit());

  // home
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepo(
      locationService: LocationService(),
      directionsService: getIt(),
      apiService: getIt(),
    ),
  );
  getIt.registerFactory<EmergencyCubit>(() => EmergencyCubit(getIt()));
  getIt.registerFactory<ScheduledCubit>(() => ScheduledCubit(getIt()));

  // requests
  getIt.registerLazySingleton<RequestsRepo>(() => RequestsRepo(getIt()));
  getIt.registerFactory<EmergencyRequestsCubit>(() => EmergencyRequestsCubit(getIt()));
  getIt.registerFactory<ScheduledRequestsCubit>(() => ScheduledRequestsCubit(getIt()));
  getIt.registerFactory<CancelCubit>(() => CancelCubit(getIt()));

  //profile
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt()));
  getIt.registerFactory<LogoutCubit>(() => LogoutCubit(getIt()));
  getIt.registerFactory<EditProfileCubit>(() => EditProfileCubit(getIt()));
}
