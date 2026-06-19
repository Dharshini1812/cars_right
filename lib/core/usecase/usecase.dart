import 'package:cars_right/core/error/faliure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type> {
  /// Callable class method
  Future<Either<Failure, Type>> call(Type params);
}

abstract class UseCaseWithoutFuture<Type, Params> {
  /// Callable class method
  Either<Failure, Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
