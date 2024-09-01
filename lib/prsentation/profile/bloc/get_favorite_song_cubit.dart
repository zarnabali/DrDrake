import 'package:drdrakify/core/usecase/auth/get_user.dart';
import 'package:drdrakify/core/usecase/song/get_favorite_song.dart';
import 'package:drdrakify/domain/entities/auth/song/songEntity.dart';
import 'package:drdrakify/prsentation/profile/bloc/get_favorite_song_state.dart';
import 'package:drdrakify/prsentation/profile/bloc/profile_info_state.dart';
import 'package:drdrakify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetFavoriteSongCubit extends Cubit<GetFavoriteSongState> {
  List<SongEntity> favoriteSongs = [];
  GetFavoriteSongCubit() : super(FavoriteSongLoading());

  Future<void> getFavoriteSongs() async {
    print('Fetching favorite songs...');
    var returnedSongs = await sl<GetFavoriteSongUsecase>().call();

    returnedSongs.fold((l) {
      print('Failed to fetch news songs: $l');
      emit(FavoriteSongFailure(message: l));
    }, (r) {
      favoriteSongs = r;
      print(
          'Favorite songs fetched successfully: ${favoriteSongs.length} songs');
      emit(FavoriteSongLoaded(songs: favoriteSongs));
    });
  }

  void removeSong(int index) {
    favoriteSongs.removeAt(index);
    emit(FavoriteSongLoaded(songs: favoriteSongs));
  }
}
