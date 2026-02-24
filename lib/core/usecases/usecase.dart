import 'package:dartz/dartz.dart';
import 'package:ebirth/core/error/failures.dart';
import 'package:equatable/equatable.dart';

/// Base UseCase contract.
/// [Type] = return type on success.
/// [Params] = input parameters (use [NoParams] if none needed).
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

