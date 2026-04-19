import 'package:dartz/dartz.dart';
import 'package:ebirth/features/doctor/domain/entities/doctor_dashboard_data.dart';
import 'package:ebirth/core/error/exceptions.dart';
import 'package:ebirth/core/error/failures.dart';
import 'package:ebirth/features/parent/domain/entities/child_entity.dart';
import 'package:ebirth/features/doctor/domain/entities/doctor_profile_entity.dart';
import 'package:ebirth/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:ebirth/features/doctor/data/datasources/doctor_remote_data_source.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DoctorDashboardData>> getDoctorDashboardData(String userId) async {
    try {
      final remoteData = await remoteDataSource.getDoctorDashboardData(userId);
      return Right(remoteData);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, ChildEntity>> searchChild(String nationalId) async {
    try {
      final remoteData = await remoteDataSource.searchChild(nationalId);
      return Right(remoteData);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'خطأ غير متوقع أثناء البحث'));
    }
  }

  @override
  Future<Either<Failure, void>> addChildMedicalRecord({
    required int childId,
    required String medicine,
    required String description,
    required List<String> imagePaths,
  }) async {
    try {
      await remoteDataSource.addChildMedicalRecord(
        childId: childId,
        medicine: medicine,
        description: description,
        imagePaths: imagePaths,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'فشل في إضافة السجل الطبي'));
    }
  }

  @override
  Future<Either<Failure, DoctorProfileEntity>> getDoctorProfile(String userId) async {
    try {
      final remoteData = await remoteDataSource.getDoctorProfile(userId);
      return Right(remoteData);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'فشل في جلب بيانات ملف الطبيب'));
    }
  }
}
