import 'package:film_list/domain/hive/hive_item_type.dart';
import 'package:film_list/ui/main_page/grid_view_dialog.dart';
import 'package:flutter/material.dart';

class GridViewVariable extends StatelessWidget {
  final List<HiveItemType> data;
  const GridViewVariable({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    int length = data.length;
    return SliverGrid.builder(
      itemBuilder: (context, index) => index < data.length
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: GridViewItem(
                index: length - index - 1,
                data: data[length - index - 1],
              ),
            )
          : Container(
            color: Colors.transparent,
            height: 0.0,
            alignment: Alignment.center,
          ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: data.length % 2 == 0 ? data.length + 2 : data.length + 3,
    );
  }
}

class GridViewItem extends StatelessWidget {
  final int index;
  final HiveItemType data;
  const GridViewItem({super.key, required this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    List<Widget> stars() {
      List<Widget> output = [];
      for (int i = 1; i <= 5; i++) {
        i <= data.rate
            ? output.add(const Icon(Icons.star))
            : output.add(const Icon(Icons.star_border));
      }
      return output;
    }

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => GridViewDialog(
            index: index,
            data: data,
          ),
        );
      },
      child: Card(
        color: Colors.transparent,
        child: Column(
          children: [
            const SizedBox(height: 8),
            Text(data.title, maxLines: 1),
            data.isWatched == true
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: stars(),
                      ),
                      Text(data.comment),
                    ],
                  )
                : const Text("Не просмотрено"),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
