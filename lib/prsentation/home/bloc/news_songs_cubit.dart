import 'package:drdrakify/core/usecase/song/getNewsSongs.dart';
import 'package:drdrakify/prsentation/home/bloc/news_songs_state.dart';
import 'package:drdrakify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    print('Fetching news songs...');
    var returnedSongs = await sl<GetNewsSongsUsecase>().call();

    returnedSongs.fold((l) {
      print('Failed to fetch news songs: $l');
      emit(NewsSongsLoadFailure(l));
    }, (data) {
      print('News songs fetched successfully: ${data.length} songs');
      emit(NewsSongsLoaded(songs: data));
    });
  }
}
