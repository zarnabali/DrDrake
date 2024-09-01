import 'package:drdrakify/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:drdrakify/common/helpers/is_dark_mode.dart';
import 'package:drdrakify/common/widgets/app_bar.dart';
import 'package:drdrakify/common/widgets/favorite_button/favorite_button.dart';
import 'package:drdrakify/core/configs/constants/app_urls.dart';
import 'package:drdrakify/prsentation/home/pages/Home.dart';
import 'package:drdrakify/prsentation/profile/bloc/get_favorite_song_cubit.dart';
import 'package:drdrakify/prsentation/profile/bloc/get_favorite_song_state.dart';
import 'package:drdrakify/prsentation/profile/bloc/profile_info_cubit.dart';
import 'package:drdrakify/prsentation/profile/bloc/profile_info_state.dart';
import 'package:drdrakify/prsentation/song_player/pages/song_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        background: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
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
        create: (context) => ProfileInfoCubit()..getUser(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileInfo(context),
              const SizedBox(
                height: 30,
              ),
              _favoriteSongs(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
        builder: (context, state) {
          if (state is ProfileInfoLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 200, 3, 244),
              ),
            );
          }
          if (state is ProfileInfoLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: state.userEntity.imageURL != null
                          ? NetworkImage(state.userEntity.imageURL!)
                          : const AssetImage('assets/default_image.png')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  state.userEntity.email ?? 'No email',
                  style: TextStyle(
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  state.userEntity.fullname ?? 'No name',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            );
          }
          if (state is ProfileInfoFailure) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _favoriteSongs(BuildContext context) {
    return BlocProvider(
      create: (context) => GetFavoriteSongCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FAVORITE SONGS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<GetFavoriteSongCubit, GetFavoriteSongState>(
                builder: (context, state) {
              if (state is FavoriteSongLoading) {
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: Color.fromARGB(255, 200, 3, 244),
                  ),
                );
              }
              if (state is FavoriteSongLoaded) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SongPlayerPage(
                                songList: state.songs, position: index),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                  '${AppURLs.firestorage}${state.songs[index].artist} - ${state.songs[index].title}.jpeg?${AppURLs.mediaAlt}',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.songs[index].title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    state.songs[index].artist,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                state.songs[index].duration
                                    .toString()
                                    .replaceAll('.', ':'),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              FavoriteButton(
                                songEntity: state.songs[index],
                                key: UniqueKey(),
                                function: () {
                                  context
                                      .read<GetFavoriteSongCubit>()
                                      .removeSong(index);
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                  itemCount: state.songs.length,
                );
              }
              if (state is FavoriteSongFailure) {
                return Text(
                  'An Error Occured try again',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                );
              }
              return Container();
            })
          ],
        ),
      ),
    );
  }
}
