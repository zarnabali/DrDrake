import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drdrakify/domain/entities/auth/song/songEntity.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;
  bool? isFavorite;
  String? songId;

  SongModel(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.releaseDate,
      required this.isFavorite,
      required this.songId});

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist_name'];
    duration = data['duration'];
    releaseDate = data['releaseDate']; // Correctly assigning to releaseDate
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
        title: title!,
        artist: artist!,
        duration: duration!,
        releaseDate: releaseDate!,
        isFavorite: isFavorite!,
        songId: songId!
        // Convert Timestamp to DateTime
        );
  }
}
