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
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(16),
        child: GridViewItem(
          index: length - index - 1,
          data: data[length - index - 1],
        ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: data.length,
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
        shape: RoundedRectangleBorder(
            side: const BorderSide(), borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            const Icon(Icons.abc),
            const Spacer(),
            const Divider(color: Colors.black),
            Text(data.title),
            data.isWatched == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: stars(),
                  )
                : const Text("Не просмотрено"),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
