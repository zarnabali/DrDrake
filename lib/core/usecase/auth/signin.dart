import 'package:dartz/dartz.dart';
import 'package:drdrakify/core/usecase/usecase.dart';
import 'package:drdrakify/data/models/auth/signin_user_request.dart';
import 'package:drdrakify/domain/usecases/auth/auth.dart';
import 'package:drdrakify/service_locator.dart';

class SignInUseCase implements Usecase<Either, SigninUserRequest> {
  @override
  Future<Either> call({SigninUserRequest? params}) async {
    return sl<AuthRepositary>().signin(params!);
  }
}
