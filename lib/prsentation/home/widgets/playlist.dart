import 'package:drdrakify/common/helpers/is_dark_mode.dart';
import 'package:drdrakify/common/widgets/favorite_button/favorite_button.dart';
import 'package:drdrakify/core/configs/themes/colors.dart';
import 'package:drdrakify/domain/entities/auth/song/songEntity.dart';
import 'package:drdrakify/prsentation/home/bloc/play_list_cubit.dart';
import 'package:drdrakify/prsentation/home/bloc/play_list_state.dart';
import 'package:drdrakify/prsentation/song_player/pages/song_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => PlayListCubit()..getPlayList(),
        child: BlocBuilder<PlayListCubit, PlayListState>(
          builder: (context, state) {
            if (state is PlayListLoading) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Color.fromARGB(255, 200, 3, 244),
                ),
              );
            }
            if (state is PlayListLoaded) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Playlist',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Text(
                          'See More',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _songs(state.songs)
                  ],
                ),
              );
            }
            return Container();
          },
        ));
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SongPlayerPage(songList: songs, position: index)),
              );
            },
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.isDarkMode
                        ? AppColors.dark_grey
                        : const Color(0xffE6E6E6),
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: context.isDarkMode
                        ? const Color(0xff959595)
                        : AppColors.dark_grey,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      songs[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      songs[index].artist,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      songs[index].duration.toString().replaceAll('.', ':'),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    FavoriteButton(songEntity: songs[index])
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
        itemCount: songs.length);
  }
}
