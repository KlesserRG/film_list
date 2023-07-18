import 'package:film_list/domain/hive/hive_item_type.dart';
import 'package:film_list/ui/main_page/main_page_delete.dart';
import 'package:film_list/ui/main_page/main_page_edit.dart';
import 'package:flutter/material.dart';

class ListViewVariable extends StatelessWidget {
  final List<HiveItemType> data;
  const ListViewVariable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    int length = data.length;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => index < data.length
            ? ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Theme.of(context).canvasColor,
                  BlendMode.srcOut,
                ),
                child: ListViewItem(
                  data: data[length - index - 1],
                  index: length - index - 1,
                ),
              )
            : Container(
                color: Theme.of(context).canvasColor,
                height: 80,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
              ),
        childCount: data.length < 10 ? 10 : data.length + 1,
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  final int index;
  final HiveItemType data;

  const ListViewItem({
    super.key,
    required this.data,
    required this.index,
  });

  List<Widget> stars() {
    List<Widget> output = [];
    for (int i = 1; i <= 5; i++) {
      i <= data.rate
          ? output.add(
              const Icon(Icons.star),
            )
          : output.add(const Icon(Icons.star_border));
      output.add(const SizedBox(width: 8));
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.isWatched
                    ? [
                        Text(data.title, style: const TextStyle(fontSize: 16)),
                        Row(children: stars()),
                        Text(data.comment)
                      ]
                    : [
                        Text(data.title, style: const TextStyle(fontSize: 16)),
                        const Text("Not watched yet",
                            style: TextStyle(fontSize: 16)),
                      ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => MainPageEdit(
                      data: data,
                      index: index,
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        MainPageDelete(data: data, index: index),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          )
        ],
      ),
    );
  }
}
