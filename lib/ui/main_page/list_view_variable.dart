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
        (context, index) => ListViewItem(
          data: data[length - index - 1],
          index: length - index - 1,
        ),
        childCount: data.length,
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
          ? output.add(const Icon(Icons.star))
          : output.add(const Icon(Icons.star_border));
      output.add(const SizedBox(width: 8));
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Icon(data.isWatched == true ? Icons.done : Icons.close),
      title: Text(data.title),
      subtitle: data.isWatched == true
          ? Row(
              children: stars(),
            )
          : const Text("Not watched yet"),
      trailing: Row(
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
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      MainPageDelete(data: data, index: index),
                );
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
    );
  }
}
