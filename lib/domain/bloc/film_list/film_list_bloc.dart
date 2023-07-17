import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:film_list/domain/hive/hive_boxes.dart';
import 'package:film_list/domain/hive/hive_item_type.dart';

part 'film_list_event.dart';
part 'film_list_state.dart';

class FilmListBloc extends Bloc<FilmListEvent, FilmListState> {
  FilmListBloc() : super(FilmListInitial()) {
    on<FilmListLoad>(_load);
    on<FilmListAdd>(_add);
    on<FilmListEdit>(_edit);
    on<FilmListDelete>(_delete);
  }

  Future<void> _load(
    FilmListLoad event,
    Emitter emit,
  ) async {
    List<HiveItemType> data = HiveBoxes.hiveItemType.values.toList();
    emit(FilmListLoaded(data: data));
  }

  Future<void> _add(
    FilmListAdd event,
    Emitter emit,
  ) async {
    HiveBoxes.hiveItemType.add(event.newData);
    List<HiveItemType> data = HiveBoxes.hiveItemType.values.toList();
    emit(FilmListLoaded(data: data));
  }

  Future<void> _edit(
    FilmListEdit event,
    Emitter emit,
  ) async {
    HiveBoxes.hiveItemType.putAt(event.index, event.editData);
    List<HiveItemType> data = HiveBoxes.hiveItemType.values.toList();
    emit(FilmListLoaded(data: data));
  }

  Future<void> _delete(
    FilmListDelete event,
    Emitter emit,
  ) async {
    HiveBoxes.hiveItemType.deleteAt(event.index);
    List<HiveItemType> data = HiveBoxes.hiveItemType.values.toList();
    emit(FilmListLoaded(data: data));
  }
}
