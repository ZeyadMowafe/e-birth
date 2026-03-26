import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/parent_entity.dart';
import '../../domain/entities/child_entity.dart';
import '../../domain/entities/vaccination_entity.dart';
import '../../domain/entities/medical_history_entity.dart';
import '../../domain/repositories/parent_repository.dart';
import '../datasources/parent_remote_data_source.dart';

class ParentRepositoryImpl implements ParentRepository {
  final ParentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ParentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ParentEntity>> getParentWithChildren(String parentId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteParent = await remoteDataSource.getParentWithChildren(parentId);
        return Right(remoteParent);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, ChildEntity>> getChildDetails(String childId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChild = await remoteDataSource.getChildDetails(childId);
        return Right(remoteChild);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<VaccinationEntity>>> getChildVaccinations(String childId) async {
    if (await networkInfo.isConnected) {
      try {
        final vaccinations = await remoteDataSource.getChildVaccinations(childId);
        return Right(vaccinations);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<MedicalHistoryEntity>>> getChildMedicalHistory(String childId) async {
    if (await networkInfo.isConnected) {
      try {
        final medicalHistory = await remoteDataSource.getChildMedicalHistory(childId);
        return Right(medicalHistory);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
