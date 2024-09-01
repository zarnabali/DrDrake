import 'package:drdrakify/core/configs/constants/app_urls.dart';
import 'package:drdrakify/domain/entities/auth/song/songEntity.dart';
import 'package:drdrakify/prsentation/song_player/bloc/song_player_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  List<SongEntity> songList = [];
  int currentIndex = 0;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      emit(SongPlayerLoaded(
        song: songList[currentIndex],
        position: songPosition,
        duration: songDuration,
      ));
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration ?? Duration.zero;
      if (songPosition == Duration.zero) {
        emit(SongPlayerLoaded(
          song: songList[currentIndex],
          position: songPosition,
          duration: songDuration,
        ));
      }
    });
  }

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  bool isShuffleMode = false;
  bool isRepeatMode = false;

  void setSongList(List<SongEntity> songs) {
    songList = songs;
  }

  Future<void> loadSong(int index) async {
    if (index < 0 || index >= songList.length) return;

    try {
      currentIndex = index;
      await audioPlayer.setUrl(
          '${AppURLs.songFirestorage}${songList[currentIndex].artist} - ${songList[currentIndex].title}.mp3?${AppURLs.mediaAlt}');
      emit(SongPlayerLoaded(
        song: songList[currentIndex],
        position: songPosition,
        duration: songDuration,
      ));
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  Future<void> playOrPauseSong() async {
    if (audioPlayer.playing) {
      audioPlayer.stop();
    } else {
      audioPlayer.play();
    }
    emit(SongPlayerLoaded(
      song: songList[currentIndex],
      position: songPosition,
      duration: songDuration,
    ));
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
  }

  void nextSong() {
    if (songList.isNotEmpty) {
      int nextIndex;
      if (isShuffleMode) {
        nextIndex = (songList.length * Random().nextDouble()).toInt();
      } else {
        nextIndex = (currentIndex + 1) % songList.length;
      }
      loadSong(nextIndex);
    }
  }

  void previousSong() {
    if (songList.isNotEmpty) {
      int prevIndex = (currentIndex - 1 + songList.length) % songList.length;
      loadSong(prevIndex);
    }
  }

  void toggleShuffleMode() {
    isShuffleMode = !isShuffleMode;
    if (isShuffleMode) {
      isRepeatMode = false;
    }
    emit(SongPlayerLoaded(
      song: songList[currentIndex],
      position: songPosition,
      duration: songDuration,
    ));
  }

  void toggleRepeatMode() {
    isRepeatMode = !isRepeatMode;
    if (isRepeatMode) {
      isShuffleMode = false;
    }
    emit(SongPlayerLoaded(
      song: songList[currentIndex],
      position: songPosition,
      duration: songDuration,
    ));
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
