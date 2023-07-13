part of 'film_list_bloc.dart';

abstract class FilmListEvent extends Equatable {
  const FilmListEvent();

  @override
  List<Object> get props => [];
}

class FilmListLoad extends FilmListEvent {
  const FilmListLoad();

  @override
  List<Object> get props => [];
}

class FilmListAdd extends FilmListEvent {
  final HiveItemType newData;
  const FilmListAdd({required this.newData});

  @override
  List<Object> get props => [newData];
}

class FilmListEdit extends FilmListEvent {
  final int index;
  final HiveItemType editData;
  const FilmListEdit({
    required this.editData,
    required this.index,
  });

  @override
  List<Object> get props => [];
}

class FilmListDelete extends FilmListEvent {
  final int index;
  final HiveItemType deleteData;
  const FilmListDelete({
    required this.deleteData,
    required this.index,
  });

  @override
  List<Object> get props => [];
}
