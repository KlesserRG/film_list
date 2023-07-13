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
  TextEditingController controller = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FilmListBloc>(context);

    if(controller.text.isEmpty && chech == false){
      controller.text = widget.data.title;
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
            controller: controller,
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
              ? Row(
                  children: _createRate(),
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
                onPressed: controller.text.isEmpty
                    ? null
                    : () {
                        bloc.add(
                          FilmListEdit(
                              editData: HiveItemType(
                                index: widget.index,
                                isWatched: isWatched!,
                                title: controller.text,
                                rate: rate!,
                                createTime: widget.data.createTime,
                                watchedTime: widget.data.isWatched == true
                                    ? widget.data.watchedTime
                                    : DateTime.now(),
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
