import 'package:dartz/dartz.dart';
import 'package:drdrakify/data/models/auth/create_user_request.dart';
import 'package:drdrakify/data/models/auth/signin_user_request.dart';

abstract class AuthRepositary {
  Future<Either<String, String>> signup(CreateUserRequest createUserReq);
  Future<Either<String, String>> signin(SigninUserRequest signinUserReq);
  Future<Either> getUser();
}
