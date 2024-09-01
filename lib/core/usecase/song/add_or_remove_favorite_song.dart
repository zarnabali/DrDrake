import 'package:dartz/dartz.dart';
import 'package:drdrakify/core/usecase/usecase.dart';
import 'package:drdrakify/data/repositary/song/song.dart';
import 'package:drdrakify/service_locator.dart';

class AddOrRemoveFavoriteSongUsecase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongsRepositary>().addOrRemoveFavoriteSong(params!);
  }
}
