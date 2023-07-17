part of 'film_list_bloc.dart';

abstract class FilmListState extends Equatable {
  const FilmListState();

  @override
  List<Object> get props => [];
}

class FilmListInitial extends FilmListState {}

class FilmListLoaded extends FilmListState {
  final List<HiveItemType> data;
  const FilmListLoaded({
    required this.data,
  });

  @override
  List<Object> get props => [data];
}
