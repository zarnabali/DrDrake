import 'package:drdrakify/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:drdrakify/core/usecase/song/add_or_remove_favorite_song.dart';
import 'package:drdrakify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  void favoriteButtonUpdated(String songId) async {
    var result =
        await sl<AddOrRemoveFavoriteSongUsecase>().call(params: songId);

    result.fold(
      (l) {},
      (isFavorite) {
        emit(
          FavoriteButtonupdated(isFavorite: isFavorite),
        );
      },
    );
  }
}
