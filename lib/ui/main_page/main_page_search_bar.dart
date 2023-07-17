import 'package:film_list/domain/bloc/film_searcher/film_searcher_bloc.dart';
import 'package:film_list/domain/hive/hive_item_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageSearchBar extends StatefulWidget {
  final List<HiveItemType> data;
  const MainPageSearchBar({super.key, required this.data});

  @override
  State<MainPageSearchBar> createState() => _MainPageSearchBarState();
}

class _MainPageSearchBarState extends State<MainPageSearchBar> {
  bool isList = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmSearcherBloc, FilmSearcherState>(
      builder: (context, state) {
        if (state is! FilmSeatcherLoaded) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        final bloc = state.data;
        return Scaffold(
          appBar: AppBar(
            title: const TextField(),
            actions: [
              IconButton(
                onPressed: () {
                  isList = !isList;
                  setState(() {});
                },
                icon: isList == true
                    ? const Icon(Icons.grid_view_sharp)
                    : const Icon(Icons.list),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SegmentedButton<int>(
                        segments: const <ButtonSegment<int>>[
                          ButtonSegment<int>(value: 1, label: Text("1")),
                          ButtonSegment<int>(value: 2, label: Text("2")),
                          ButtonSegment<int>(value: 3, label: Text("3")),
                          ButtonSegment<int>(value: 4, label: Text("4")),
                          ButtonSegment<int>(value: 5, label: Text("5")),
                        ],
                        selected: state.rate,
                        onSelectionChanged: (Set<int> newSelected) {},
                        multiSelectionEnabled: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Watched",
                            style: TextStyle(fontSize: 16),
                          ),
                          Checkbox(
                            value: state.isWatched,
                            onChanged: (value) {
                              print("object");
                              BlocProvider.of<FilmSearcherBloc>(context).add(
                                FilmSearcherSortEvent(
                                  isWatched: !state.isWatched,
                                  data: widget.data,
                                ),
                              );
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
