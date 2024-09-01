abstract class FavoriteButtonState {}

class FavoriteButtonInitial extends FavoriteButtonState {}

class FavoriteButtonupdated extends FavoriteButtonState {
  final bool isFavorite;
  FavoriteButtonupdated({required this.isFavorite});
}
