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
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerComment = TextEditingController();

  bool isWatched = false;
  bool firstStart = true;
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
    if (firstStart) {
      controllerTitle.text = widget.data.title;
      controllerComment.text = widget.data.comment;
    }
    return AlertDialog(
      title: const Text("Edit current"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Enter Title name"),
            controller: controllerTitle,
            // onChanged: (text) {
            //   title = text;
            //   setState(() {});
            // },
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
              ? Column(
                  children: [
                    Row(
                      children: _createRate(),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Your Opinion",
                      ),
                      controller: controllerComment,
                    )
                  ],
                )
              : const SizedBox(),
          IconButton(
            onPressed: controllerTitle.text.isEmpty
                ? null
                : () {
                    bloc.add(
                      FilmListEdit(
                        index: widget.index,
                        editData: HiveItemType(
                          index: widget.data.index,
                          isWatched: isWatched,
                          title: controllerTitle.text,
                          rate: rate,
                          createTime: widget.data.createTime,
                          watchedTime: widget.data.isWatched == true
                              ? widget.data.watchedTime
                              : DateTime.now(),
                          comment: controllerComment.text.isNotEmpty
                              ? controllerComment.text
                              : widget.data.comment,
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
