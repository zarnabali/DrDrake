import 'package:drdrakify/domain/entities/auth/song/songEntity.dart';

abstract class GetFavoriteSongState {}

class FavoriteSongLoading extends GetFavoriteSongState {}

class FavoriteSongLoaded extends GetFavoriteSongState {
  final List<SongEntity> songs;
  FavoriteSongLoaded({required this.songs});
}

class FavoriteSongFailure extends GetFavoriteSongState {
  final String message;

  FavoriteSongFailure({required this.message});
}
