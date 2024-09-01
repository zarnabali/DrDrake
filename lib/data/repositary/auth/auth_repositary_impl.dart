import 'package:dartz/dartz.dart';
import 'package:drdrakify/data/models/auth/create_user_request.dart';
import 'package:drdrakify/data/models/auth/signin_user_request.dart';
import 'package:drdrakify/data/source/auth/auth_firebase_service.dart';
import 'package:drdrakify/domain/usecases/auth/auth.dart';
import 'package:drdrakify/service_locator.dart';

class AuthRepositaryImpl extends AuthRepositary {
  @override
  Future<Either<String, String>> signin(SigninUserRequest signinUserReq) async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either<String, String>> signup(CreateUserRequest createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }

  @override
  Future<Either> getUser() async {
    return await sl<AuthFirebaseService>().getUser();
  }
}
