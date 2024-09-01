import 'package:drdrakify/core/usecase/auth/get_user.dart';
import 'package:drdrakify/prsentation/profile/bloc/profile_info_state.dart';
import 'package:drdrakify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var userResult = await sl<GetUserUseCase>().call();

    userResult.fold(
      (failureMessage) {
        emit(ProfileInfoFailure(message: failureMessage));
      },
      (userEntity) {
        emit(ProfileInfoLoaded(userEntity: userEntity));
      },
    );
  }
}
