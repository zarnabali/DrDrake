import 'package:drdrakify/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:drdrakify/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:drdrakify/common/helpers/is_dark_mode.dart';
import 'package:drdrakify/core/configs/themes/colors.dart';
import 'package:drdrakify/domain/entities/auth/song/songEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;
  const FavoriteButton({required this.songEntity, this.function, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () async {
                context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdated(songEntity.songId);
                if (function != null) {
                  function!();
                }
              },
              icon: Icon(
                songEntity.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_rounded,
                color: context.isDarkMode ? AppColors.dark_grey : Colors.black,
              ),
            );
          }
          if (state is FavoriteButtonupdated) {
            return IconButton(
              onPressed: () {
                context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdated(songEntity.songId);
              },
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_rounded,
                color: context.isDarkMode ? AppColors.dark_grey : Colors.black,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
