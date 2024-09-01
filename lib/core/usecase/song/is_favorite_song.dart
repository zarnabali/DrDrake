import 'package:drdrakify/core/usecase/usecase.dart';
import 'package:drdrakify/data/repositary/song/song.dart';
import 'package:drdrakify/service_locator.dart';

class IsFavoriteSongUsecase implements Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongsRepositary>().isFavoriteSong(params!);
  }
}
