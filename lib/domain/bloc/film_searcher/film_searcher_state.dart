part of 'film_searcher_bloc.dart';

abstract class FilmSearcherState extends Equatable {
  const FilmSearcherState();
  
  @override
  List<Object> get props => [];
}

class FilmSearcherInitial extends FilmSearcherState {}

class FilmSeatcherLoaded extends FilmSearcherState{
  final String text;
  final bool isWatched;
  final Set<int> rate;
  final List<HiveItemType> data;

  const FilmSeatcherLoaded({
    required this.text,
    required this.isWatched,
    required this.rate,
    this.data = const [],
  });

  @override
  List<Object> get props => [];
}
