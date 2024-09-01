// ignore_for_file: unused_local_variable

import 'package:drdrakify/common/helpers/is_dark_mode.dart';
import 'package:drdrakify/common/widgets/app_bar.dart';
import 'package:drdrakify/common/widgets/favorite_button/favorite_button.dart';
import 'package:drdrakify/core/configs/constants/app_urls.dart';
// ignore: unused_import
import 'package:drdrakify/core/configs/themes/colors.dart';
import 'package:drdrakify/domain/entities/auth/song/songEntity.dart';
import 'package:drdrakify/prsentation/home/pages/Home.dart';
import 'package:drdrakify/prsentation/song_player/bloc/song_player_cubit.dart';
import 'package:drdrakify/prsentation/song_player/bloc/song_player_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongPlayerPage extends StatelessWidget {
  final List<SongEntity> songList;
  final int position;

  const SongPlayerPage(
      {required this.songList, required this.position, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(
          'Now Playing',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        action: IconButton(
          icon: Icon(
            Icons.more_vert_rounded,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {},
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Home(),
            ),
          );
        },
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()
          ..setSongList(songList)
          ..loadSong(position), // Load the initial song
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: BlocBuilder<SongPlayerCubit, SongPlayerState>(
            builder: (context, state) {
              if (state is SongPlayerLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 200, 3, 244),
                  ),
                );
              }
              if (state is SongPlayerLoaded) {
                final cubit = context.read<SongPlayerCubit>();
                final song = state.song;
                final position = cubit.songPosition.inSeconds.toDouble();
                final duration = cubit.songDuration.inSeconds.toDouble();

                return Column(
                  children: [
                    _songCover(context, song),
                    const SizedBox(height: 10),
                    _songDetail(context, song),
                    const SizedBox(height: 30),
                    _songPlayer(context),
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context, SongEntity song) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              '${AppURLs.firestorage}${song.artist} - ${song.title}.jpeg?${AppURLs.mediaAlt}'),
        ),
      ),
    );
  }

  Widget _songDetail(BuildContext context, SongEntity song) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  song.artist,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 35,
          child: Align(
              alignment: Alignment.center,
              child: FavoriteButton(
                songEntity: song,
              )),
        ),
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 200, 3, 244),
            ),
          );
        }
        if (state is SongPlayerLoaded) {
          final cubit = context.read<SongPlayerCubit>();
          final position = cubit.songPosition.inSeconds.toDouble();
          final duration = cubit.songDuration.inSeconds.toDouble();

          return Column(
            children: [
              Slider(
                value: position,
                min: 0.0,
                max: duration,
                onChanged: (value) {
                  cubit.seekTo(Duration(seconds: value.toInt()));
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      formatDuration(cubit.songPosition),
                      style: TextStyle(
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      formatDuration(cubit.songDuration),
                      style: TextStyle(
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.repeat,
                      color: cubit.isRepeatMode
                          ? Colors.purple
                          : context.isDarkMode
                              ? Colors.white
                              : Colors.black,
                    ),
                    onPressed: () {
                      context.read<SongPlayerCubit>().toggleRepeatMode();
                    },
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      color: context.isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      context.read<SongPlayerCubit>().previousSong();
                    },
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      context.read<SongPlayerCubit>().playOrPauseSong();
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFFD319),
                            Color(0xFFFF2975),
                            Color(0xFF8C1EFF)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          cubit.audioPlayer.playing
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      color: context.isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      context.read<SongPlayerCubit>().nextSong();
                    },
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: Icon(
                      Icons.shuffle,
                      color: cubit.isShuffleMode
                          ? const Color.fromARGB(255, 200, 3, 244)
                          : context.isDarkMode
                              ? Colors.white
                              : Colors.black,
                    ),
                    onPressed: () {
                      context.read<SongPlayerCubit>().toggleShuffleMode();
                    },
                  ),
                ],
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
