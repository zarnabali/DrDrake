import 'package:drdrakify/core/usecase/song/getPlayList.dart';
import 'package:drdrakify/prsentation/home/bloc/play_list_state.dart';
import 'package:drdrakify/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    print('Fetching news songs...');
    var returnedSongs = await sl<GetPlayListUseCase>().call();

    returnedSongs.fold((l) {
      print('Failed to fetch news songs: $l');
      emit(PlayListLoadFailure(l));
    }, (data) {
      print('News songs fetched successfully: ${data.length} songs');
      emit(PlayListLoaded(songs: data));
    });
  }
}
