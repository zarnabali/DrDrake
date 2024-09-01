import 'package:dartz/dartz.dart';
import 'package:drdrakify/data/repositary/song/song.dart';
import 'package:drdrakify/data/source/song/songFirebaseService.dart';
import 'package:drdrakify/domain/entities/auth/song/songEntity.dart';
import 'package:drdrakify/failure.dart';
import 'package:drdrakify/service_locator.dart';

class SongRepositaryImp extends SongsRepositary {
  @override
  Future<Either<Failure, List<SongEntity>>> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getPlayList() async {
    return await sl<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either<Failure, bool>> addOrRemoveFavoriteSong(String songId) async {
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSong(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    return await sl<SongFirebaseService>().isFavoriteSong(songId);
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    return await sl<SongFirebaseService>().getUserFavoriteSongs();
  }
}
