import 'package:film_list/domain/bloc/film_list_bloc.dart';
import 'package:film_list/domain/hive/hive_item_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageEdit extends StatefulWidget {
  final HiveItemType data;
  final int index;
  const MainPageEdit({super.key, required this.data, required this.index});

  @override
  State<MainPageEdit> createState() => _MainPageEditState();
}

class _MainPageEditState extends State<MainPageEdit> {
  TextEditingController controller = TextEditingController();

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
      title: const Text("Edit current"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Enter Title name"),
            // controller: controller,
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
                      FilmListEdit(
                        index: widget.index,
                        editData: HiveItemType(
                          index: widget.data.index,
                          isWatched: isWatched,
                          title: title!,
                          rate: rate,
                          createTime: widget.data.createTime,
                          watchedTime: widget.data.isWatched == true
                                    ? widget.data.watchedTime
                                    : DateTime.now(),
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
