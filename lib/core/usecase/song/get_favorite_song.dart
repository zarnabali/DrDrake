import 'package:dartz/dartz.dart';
import 'package:drdrakify/core/usecase/usecase.dart';
import 'package:drdrakify/data/repositary/song/song.dart';
import 'package:drdrakify/service_locator.dart';

class GetFavoriteSongUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepositary>().getUserFavoriteSongs();
  }
}
