import 'package:equatable/equatable.dart';
import 'package:film_list/domain/hive/hive_item_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'film_searcher_event.dart';
part 'film_searcher_state.dart';

class FilmSearcherBloc extends Bloc<FilmSearcherEvent, FilmSearcherState> {
  FilmSearcherBloc() : super(FilmSearcherInitial()) {
    on<FilmSearcherEvent>((event, emit) {});
    on<FilmSearcherLoadEvent>(load);
    on<FilmSearcherSortEvent>(sort);
  }

  Future<void> load(
    FilmSearcherLoadEvent event,
    Emitter emit,
  ) async {
    emit(
      const FilmSeatcherLoaded(
        isWatched: true,
        rate: {4, 5},
        text: '',
      ),
    );
  }

  Future<void> sort(
    FilmSearcherSortEvent event,
    Emitter emit,
  ) async {
    try {
      List<HiveItemType> data = event.data;
      Set<HiveItemType> sorted = {};

      if (event.isWatched == false) {
        for (int i = 0; i < data.length; i++) {
          if (data[i].isWatched == false) {
            sorted.add(data[i]);
          }
        }
      }

      if (event.isWatched == true) {
        for (int i = 0; i < data.length; i++) {
          if (event.rate.contains(data[i].rate)) {
            sorted.add(data[i]);
          }
        }
      }

      if (event.name.isEmpty) {
        for (int i = 0; i < data.length; i++) {
          if (data[i].title.split(' ').contains(event.name)) {
            sorted.add(data[i]);
          }
        }
      }

      emit(
        FilmSeatcherLoaded(
          data: sorted.toList(),
          isWatched: event.isWatched,
          rate: event.rate,
          text: event.name,
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
