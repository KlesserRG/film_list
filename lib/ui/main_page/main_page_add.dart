import 'package:film_list/domain/bloc/film_list_bloc.dart';
import 'package:film_list/domain/hive/hive_boxes.dart';
import 'package:film_list/domain/hive/hive_item_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageAdd extends StatefulWidget {
  const MainPageAdd({super.key});

  @override
  State<MainPageAdd> createState() => _MainPageAddState();
}

class _MainPageAddState extends State<MainPageAdd> {
  String? title;
  bool isWatched = false;
  int rate = 1;
  List<IconButton> _createRate() {
    List<IconButton> list = [];
    for (int i = 1; i <= 5; i++) {
      list.add(
        IconButton(
          onPressed: () {
            rate = i;
            setState(() {});
          },
          icon: i <= rate
              ? const Icon(Icons.star)
              : const Icon(Icons.star_border),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FilmListBloc>(context);
    return AlertDialog(
      title: const Text("Add new Title"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            autofocus: false,
            decoration: const InputDecoration(labelText: "Enter Title name"),
            onChanged: (text) {
              title = text;
              setState(() {});
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("Is Watched?"),
              Checkbox(
                value: isWatched,
                onChanged: (chechbox) {
                  isWatched = chechbox!;
                  setState(() {});
                },
              ),
            ],
          ),
          isWatched == true
              ? Row(
                  children: _createRate(),
                )
              : const SizedBox(),
          IconButton(
            onPressed: title == null
                ? null
                : () {
                    bloc.add(
                      FilmListAdd(
                        newData: HiveItemType(
                          index: HiveBoxes.hiveItemType.values.length,
                          isWatched: isWatched,
                          title: title!,
                          rate: rate,
                          createTime: DateTime.now(),
                          watchedTime: DateTime.now(),
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
    );
  }
}
