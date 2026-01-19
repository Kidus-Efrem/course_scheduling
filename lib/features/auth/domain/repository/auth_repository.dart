import 'package:course_scheduling/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPasswrod({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, Map<String, dynamic>>> getProfile({
    required String userId,
  });
}
