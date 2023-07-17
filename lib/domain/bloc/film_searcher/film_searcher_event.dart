part of 'film_searcher_bloc.dart';

abstract class FilmSearcherEvent extends Equatable {
  const FilmSearcherEvent();

  @override
  List<Object> get props => [];
}

class FilmSearcherLoadEvent extends FilmSearcherEvent {
  const FilmSearcherLoadEvent();

  @override
  List<Object> get props => [];
}

class FilmSearcherSortEvent extends FilmSearcherEvent {
  final List<HiveItemType> data;
  final Set<int> rate;
  final bool isWatched;
  final String name;
  const FilmSearcherSortEvent({
    required this.data,
    this.isWatched = true,
    this.name = '',
    this.rate = const {4,5},
  });

  @override
  List<Object> get props => [data];
}
