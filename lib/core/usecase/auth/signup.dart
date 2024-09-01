import 'package:dartz/dartz.dart';
import 'package:drdrakify/core/usecase/usecase.dart';
import 'package:drdrakify/data/models/auth/create_user_request.dart';
import 'package:drdrakify/domain/usecases/auth/auth.dart';
import 'package:drdrakify/service_locator.dart';

class SignupUseCase implements Usecase<Either, CreateUserRequest> {
  @override
  Future<Either> call({CreateUserRequest? params}) {
    return sl<AuthRepositary>().signup(params!);
  }
}
