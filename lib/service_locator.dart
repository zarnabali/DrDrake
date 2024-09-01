// Import necessary packages and files
import 'package:drdrakify/core/usecase/auth/get_user.dart';
import 'package:drdrakify/core/usecase/auth/signin.dart';
import 'package:drdrakify/core/usecase/auth/signup.dart';
import 'package:drdrakify/core/usecase/song/add_or_remove_favorite_song.dart';
import 'package:drdrakify/core/usecase/song/getNewsSongs.dart';
import 'package:drdrakify/core/usecase/song/getPlayList.dart';
import 'package:drdrakify/core/usecase/song/get_favorite_song.dart';
import 'package:drdrakify/core/usecase/song/is_favorite_song.dart';
import 'package:drdrakify/data/repositary/auth/auth_repositary_impl.dart';
import 'package:drdrakify/data/repositary/song/song.dart';
import 'package:drdrakify/data/repositary/song/song_repositary_imp.dart';
import 'package:drdrakify/data/source/auth/auth_firebase_service.dart';
import 'package:drdrakify/data/source/song/songFirebaseService.dart';
import 'package:drdrakify/domain/usecases/auth/auth.dart';
import 'package:get_it/get_it.dart';

// Create an instance of GetIt, which acts as the service locator
final sl = GetIt.instance;

// Function to initialize and register dependencies
Future<void> initializeDependencies() async {
  // Register the AuthFirebaseService with its implementation as a singleton
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseSeviceImplementation());

  // Register the AuthRepositary with its implementation as a singleton
  sl.registerSingleton<AuthRepositary>(AuthRepositaryImpl());

  // Register SongFirebaseService and repository implementations
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImp());
  sl.registerSingleton<SongsRepositary>(SongRepositaryImp());

  // Register Usecases
  sl.registerSingleton<GetNewsSongsUsecase>(GetNewsSongsUsecase());
  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<IsFavoriteSongUsecase>(IsFavoriteSongUsecase());
  sl.registerSingleton<AddOrRemoveFavoriteSongUsecase>(
      AddOrRemoveFavoriteSongUsecase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<GetFavoriteSongUsecase>(GetFavoriteSongUsecase());
}
