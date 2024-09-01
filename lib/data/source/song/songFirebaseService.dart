// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:drdrakify/core/usecase/song/is_favorite_song.dart';
import 'package:drdrakify/data/models/song/songModel.dart';
import 'package:drdrakify/domain/entities/auth/song/songEntity.dart';
import 'package:drdrakify/failure.dart';
import 'package:drdrakify/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SongFirebaseService {
  Future<Either<Failure, List<SongEntity>>> getNewsSongs();
  Future<Either<Failure, List<SongEntity>>> getPlayList();
  Future<Either<Failure, bool>> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
}

class SongFirebaseServiceImp extends SongFirebaseService {
  @override
  Future<Either<Failure, List<SongEntity>>> getNewsSongs() async {
    const int maxRetries = 3;
    int attempt = 0;

    while (attempt < maxRetries) {
      try {
        List<SongEntity> songs = [];
        var data = await FirebaseFirestore.instance
            .collection('Songs')
            .orderBy('releaseDate', descending: true)
            .limit(4)
            .get();

        for (var element in data.docs) {
          var songModel = SongModel.fromJson(element.data());
          bool isFavorite = await sl<IsFavoriteSongUsecase>()
              .call(params: element.reference.id);
          songModel.isFavorite = isFavorite;
          songModel.songId = element.reference.id;
          songs.add(songModel.toEntity());
        }
        return Right(songs);
      } catch (e, stackTrace) {
        attempt++;
        if (attempt >= maxRetries) {
          print('Error fetching news songs after $attempt attempts: $e');
          print('Stack trace: $stackTrace');
          return Left(Failure('An error occurred, Please try again'));
        }
      }
    }
    return Left(Failure('Failed after retrying'));
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getPlayList() async {
    const int maxRetries = 3;
    int attempt = 0;

    while (attempt < maxRetries) {
      try {
        List<SongEntity> songs = [];
        var data = await FirebaseFirestore.instance
            .collection('Songs')
            .orderBy('releaseDate', descending: true)
            .get();

        for (var element in data.docs) {
          var songModel = SongModel.fromJson(element.data());
          bool isFavorite = await sl<IsFavoriteSongUsecase>()
              .call(params: element.reference.id);
          songModel.isFavorite = isFavorite;
          songModel.songId = element.reference.id;
          songs.add(songModel.toEntity());
        }
        return Right(songs);
      } catch (e, stackTrace) {
        attempt++;
        if (attempt >= maxRetries) {
          print('Error fetching news songs after $attempt attempts: $e');
          print('Stack trace: $stackTrace');
          return Left(Failure('An error occurred, Please try again'));
        }
      }
    }
    return Left(Failure('Failed after retrying'));
  }

  @override
  Future<Either<Failure, bool>> addOrRemoveFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      bool isFavorite;
      if (favoriteSongs.docs.isNotEmpty) {
        // Remove from favorites
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        // Add to favorites
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add({
          'songId': songId,
          'addedDate': Timestamp.now(),
        });
        isFavorite = true;
      }

      return Right(isFavorite);
    } catch (e, stackTrace) {
      print('Error adding or removing favorite song: $e');
      print('Stack trace: $stackTrace');
      return Left(Failure('An error occurred while updating favorite status'));
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      late bool isFavorite;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      late bool isFavorite;
      var user = firebaseAuth.currentUser;
      List<SongEntity> favoriteSong = [];
      String uId = user!.uid;
      QuerySnapshot favoritesSnapshot = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .get();

      for (var element in favoritesSnapshot.docs) {
        String songId = element['songId'];
        var song =
            await firebaseFirestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite = true;
        songModel.songId = songId;
        favoriteSong.add(songModel.toEntity());
      }
      return Right(favoriteSong);
    } catch (e) {
      return Left('An error occurred, Please try again $e');
    }
  }
}
