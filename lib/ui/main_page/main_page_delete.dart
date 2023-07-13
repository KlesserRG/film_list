import 'package:film_list/domain/bloc/film_list_bloc.dart';
import 'package:film_list/domain/hive/hive_item_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageDelete extends StatelessWidget {
  final HiveItemType data;
  final int index;
  const MainPageDelete({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FilmListBloc>(context);
    return AlertDialog(
      title: const Text("Are you shure about that?"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          IconButton(
            onPressed: () {
              bloc.add(FilmListDelete(deleteData: data, index: index));
              Navigator.pop(context);
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
    );
  }
}
