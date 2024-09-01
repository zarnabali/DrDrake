import 'package:dartz/dartz.dart';
import 'package:drdrakify/domain/entities/auth/song/songEntity.dart';
import 'package:drdrakify/failure.dart';

abstract class SongsRepositary {
  Future<Either<Failure, List<SongEntity>>> getNewsSongs();
  Future<Either<Failure, List<SongEntity>>> getPlayList();
  Future<Either<Failure, bool>> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
}
