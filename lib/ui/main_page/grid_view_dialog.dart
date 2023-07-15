import 'package:film_list/domain/bloc/film_list_bloc.dart';
import 'package:film_list/domain/hive/hive_item_type.dart';
import 'package:film_list/ui/main_page/main_page_delete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridViewDialog extends StatefulWidget {
  final int index;
  final HiveItemType data;
  const GridViewDialog({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  State<GridViewDialog> createState() => _GridViewDialogState();
}

class _GridViewDialogState extends State<GridViewDialog> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerComment = TextEditingController();

  bool chech = false;
  bool? isWatched;
  int? rate;
  List<IconButton> _createRate() {
    List<IconButton> list = [];
    for (int i = 1; i <= 5; i++) {
      list.add(
        IconButton(
          onPressed: () {
            rate = i;
            setState(() {});
          },
          icon: i <= rate!
              ? const Icon(Icons.star)
              : const Icon(Icons.star_border),
        ),
      );
    }
    return list;
  }

  String _createComment() {
    if (rate == 1) {
      return "Really bad";
    }
    if (rate == 2) {
      return "Not so bad";
    }
    if (rate == 3) {
      return "Something for everyone";
    }
    if (rate == 4) {
      return "Good. Really good.";
    }
    if (rate == 5) {
      return "That was amazing!";
    }
    return "COMMENT ERROR";
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FilmListBloc>(context);

    if (controllerTitle.text.isEmpty && chech == false) {
      controllerTitle.text = widget.data.title;
      chech = true;
    }
    isWatched ??= widget.data.isWatched;
    rate ??= widget.data.rate;

    return AlertDialog(
      title: const Text("Change Current"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Enter Title name"),
            controller: controllerTitle,
            onChanged: (value) {
              setState(() {});
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Is watched?"),
              Checkbox(
                value: isWatched,
                onChanged: (chechbox) {
                  isWatched = !isWatched!;
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
                        labelText: "Comment your feeling!",
                      ),
                      controller: controllerComment,
                    ),
                  ],
                )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => MainPageDelete(
                      data: widget.data,
                      index: widget.index,
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
              IconButton(
                onPressed: controllerTitle.text.isEmpty
                    ? null
                    : () {
                        bloc.add(
                          FilmListEdit(
                              editData: HiveItemType(
                                index: widget.index,
                                isWatched: isWatched!,
                                title: controllerTitle.text,
                                rate: rate!,
                                createTime: widget.data.createTime,
                                watchedTime: widget.data.isWatched == true
                                    ? widget.data.watchedTime
                                    : DateTime.now(),
                                comment: controllerComment.text.isNotEmpty
                                    ? controllerComment.text
                                    : _createComment(),
                              ),
                              index: widget.index),
                        );
                        Navigator.pop(context);
                      },
                icon: const Icon(Icons.done),
              ),
            ],
          )
        ],
      ),
    );
  }
}
