import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:ebirth/core/constants/api_constants.dart';
import 'package:ebirth/core/network/network_info.dart';
import 'package:ebirth/core/network/network_info_impl.dart';
import 'package:ebirth/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ebirth/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ebirth/features/auth/domain/repositories/auth_repository.dart';
import 'package:ebirth/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:ebirth/features/auth/domain/usecases/login_usecase.dart';
import 'package:ebirth/features/auth/domain/usecases/register_usecase.dart';
import 'package:ebirth/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:ebirth/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:ebirth/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/login_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/register_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/verify_otp_cubit.dart';

/// Global service locator instance.
final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  // ─── Core ────────────────────────────────────────────────────────────────

  // Network
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Dio (configured for easy backend switching)
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
        ),
      );
    }
    return dio;
  });

  // ─── Auth Feature ────────────────────────────────────────────────────────

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(repository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(repository: sl()));

  // Cubit — factory so a fresh instance is created every time
  sl.registerFactory<LoginCubit>(() => LoginCubit(loginUseCase: sl()));
  sl.registerFactory<RegisterCubit>(() => RegisterCubit(registerUseCase: sl()));
  sl.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(forgotPasswordUseCase: sl()),
  );
  sl.registerFactory<VerifyOtpCubit>(
    () => VerifyOtpCubit(verifyOtpUseCase: sl()),
  );
  sl.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(resetPasswordUseCase: sl()),
  );
}
