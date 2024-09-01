import 'package:drdrakify/domain/entities/auth/song/songEntity.dart';
import 'package:drdrakify/failure.dart';

abstract class NewsSongsState {}

class NewsSongsLoading extends NewsSongsState {}

class NewsSongsLoaded extends NewsSongsState {
  final List<SongEntity> songs;
  NewsSongsLoaded({required this.songs});
}

class NewsSongsLoadFailure extends NewsSongsState {
  final Failure failure;
  NewsSongsLoadFailure(this.failure);
}
