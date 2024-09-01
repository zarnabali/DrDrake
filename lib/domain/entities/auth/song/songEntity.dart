import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final bool isFavorite;
  final String songId;

  SongEntity(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.releaseDate,
      required this.isFavorite,
      required this.songId});

  static SongEntity get empty => SongEntity(
      title: 'Unknown Title',
      artist: 'Unknown Artist',
      duration: 0,
      releaseDate: Timestamp.fromDate(DateTime.now()),
      isFavorite: false,
      songId: 'null' // Or use a default date
      );
}
