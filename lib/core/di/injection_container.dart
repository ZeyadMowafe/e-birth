import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:ebirth/core/constants/api_constants.dart';
import 'package:ebirth/core/network/network_info.dart';
import 'package:ebirth/core/network/network_info_impl.dart';
import 'package:ebirth/core/helper/shared_prefs_helper.dart';
import 'package:ebirth/core/helper/auth_token_holder.dart';
import 'package:ebirth/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ebirth/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ebirth/features/auth/domain/repositories/auth_repository.dart';
import 'package:ebirth/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:ebirth/features/auth/domain/usecases/login_usecase.dart';
import 'package:ebirth/features/auth/domain/usecases/register_usecase.dart';
import 'package:ebirth/features/auth/domain/usecases/register_doctor_usecase.dart';
import 'package:ebirth/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:ebirth/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:ebirth/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/login_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/register_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:ebirth/features/auth/presentation/cubit/verify_otp_cubit.dart';

// ─── Parent Feature Imports ──────────────────────────────────────────────
import 'package:ebirth/features/parent/data/datasources/parent_remote_data_source.dart';
import 'package:ebirth/features/parent/data/datasources/parent_remote_data_source_impl.dart';
import 'package:ebirth/features/parent/data/repositories/parent_repository_impl.dart';
import 'package:ebirth/features/parent/domain/repositories/parent_repository.dart';
import 'package:ebirth/features/parent/domain/usecases/get_parent_with_children.dart';
import 'package:ebirth/features/parent/domain/usecases/get_parent_details_usecase.dart';
import 'package:ebirth/features/parent/domain/usecases/get_child_details.dart';
import 'package:ebirth/features/parent/domain/usecases/get_child_vaccinations.dart';
import 'package:ebirth/features/parent/domain/usecases/get_child_medical_history.dart';
import 'package:ebirth/features/parent/domain/usecases/get_parent_medical_history.dart';
import 'package:ebirth/features/parent/domain/usecases/get_specific_child_medical_history.dart';
import 'package:ebirth/features/parent/domain/usecases/get_specific_parent_medical_history.dart';
import 'package:ebirth/features/parent/presentation/cubit/parent_cubit.dart';
import 'package:ebirth/features/parent/presentation/cubit/child_details_cubit.dart';
import 'package:ebirth/features/parent/presentation/cubit/parent_profile_cubit.dart';
import 'package:ebirth/features/parent/presentation/cubit/parent_medical_history_cubit.dart';
import 'package:ebirth/features/parent/presentation/cubit/medical_record_detail_cubit.dart';

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

    // Add Auth Interceptor to automatically inject token
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Prefer in-memory token (fast, no async), fall back to SharedPrefs on app restart
          String? token = AuthTokenHolder.token;
          if (token == null || token.isEmpty) {
            token = await SharedPrefsHelper.getToken();
            if (token != null && token.isNotEmpty) {
              AuthTokenHolder.setToken(token); // warm up in-memory cache
            }
          }
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          debugPrint('[AuthInterceptor] token=${token?.substring(0, 20)}... → ${options.uri}');
          return handler.next(options);
        },
      ),
    );

    // Bypass SSL certificate errors in debug mode (e.g. self-signed certs on shared hosting)
    if (kDebugMode) {
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.badCertificateCallback = (cert, host, port) => true;
          return client;
        },
      );
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
  sl.registerLazySingleton(() => RegisterDoctorUseCase(repository: sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(repository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(repository: sl()));

  // Cubit — factory so a fresh instance is created every time
  sl.registerFactory<LoginCubit>(() => LoginCubit(loginUseCase: sl()));
  sl.registerFactory<RegisterCubit>(
    () => RegisterCubit(registerUseCase: sl(), registerDoctorUseCase: sl()),
  );
  sl.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(forgotPasswordUseCase: sl()),
  );
  sl.registerFactory<VerifyOtpCubit>(
    () => VerifyOtpCubit(verifyOtpUseCase: sl()),
  );
  sl.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(resetPasswordUseCase: sl()),
  );

  // ─── Parent Feature ──────────────────────────────────────────────────────

  // Data Sources
  sl.registerLazySingleton<ParentRemoteDataSource>(
    () => ParentRemoteDataSourceImpl(dio: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ParentRepository>(
    () => ParentRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetParentWithChildrenUseCase(sl()));
  sl.registerLazySingleton(() => GetParentDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetChildDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetChildVaccinationsUseCase(sl()));
  sl.registerLazySingleton(() => GetChildMedicalHistoryUseCase(sl()));
  sl.registerLazySingleton(() => GetParentMedicalHistoryUseCase(sl()));
  sl.registerLazySingleton(() => GetSpecificChildMedicalHistoryUseCase(sl()));
  sl.registerLazySingleton(() => GetSpecificParentMedicalHistoryUseCase(sl()));

  // Cubits
  sl.registerFactory<ParentCubit>(() => ParentCubit(getParentWithChildrenUseCase: sl()));
  sl.registerFactory<ParentProfileCubit>(() => ParentProfileCubit(
    getParentDetailsUseCase: sl(),
    getParentWithChildrenUseCase: sl(),
  ));
  sl.registerFactory<ParentMedicalHistoryCubit>(() => ParentMedicalHistoryCubit(
    getParentMedicalHistoryUseCase: sl(),
    getParentWithChildrenUseCase: sl(),
  ));
  sl.registerFactory<MedicalRecordDetailCubit>(() => MedicalRecordDetailCubit(
    getSpecificChildMedicalHistoryUseCase: sl(),
    getSpecificParentMedicalHistoryUseCase: sl(),
  ));
  sl.registerFactory<ChildDetailsCubit>(
    () => ChildDetailsCubit(
      getChildDetailsUseCase: sl(),
      getChildVaccinationsUseCase: sl(),
      getChildMedicalHistoryUseCase: sl(),
    ),
  );
}

