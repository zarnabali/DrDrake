import 'package:drdrakify/domain/entities/auth/song/songEntity.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {
  final SongEntity song;
  final Duration position;
  final Duration duration;

  SongPlayerLoaded({
    required this.song,
    required this.position,
    required this.duration,
  });
}

class SongPlayerFailure extends SongPlayerState {}
