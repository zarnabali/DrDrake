import 'package:dartz/dartz.dart';
import 'package:drdrakify/core/usecase/usecase.dart';
import 'package:drdrakify/data/repositary/song/song.dart';
import 'package:drdrakify/data/repositary/song/song_repositary_imp.dart';
import 'package:drdrakify/domain/entities/auth/song/songEntity.dart';
import 'package:drdrakify/failure.dart';
import 'package:drdrakify/service_locator.dart';

class GetNewsSongsUsecase
    implements Usecase<Either<Failure, List<SongEntity>>, dynamic> {
  @override
  Future<Either<Failure, List<SongEntity>>> call({dynamic params}) async {
    return await sl<SongsRepositary>().getNewsSongs();
  }
}
