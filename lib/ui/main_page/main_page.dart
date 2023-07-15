import 'package:film_list/domain/bloc/film_list_bloc.dart';
import 'package:film_list/ui/main_page/grid_view_variable.dart';
import 'package:film_list/ui/main_page/list_view_variable.dart';
import 'package:film_list/ui/main_page/main_page_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isList = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmListBloc, FilmListState>(
      builder: (context, state) {
        if (state is! FilmListLoaded) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final data = state.data;
        return Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.pinkAccent,
                    Colors.deepPurpleAccent,
                    Colors.blue,
                  ],
                ),
              ),
            ),
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).canvasColor, BlendMode.srcOut),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                  title: const Text("Film List"),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.adb_rounded))
                  ],
                ),
                // drawer: const MainPageDrawer,
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      leading: null,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      elevation: 0,
                      scrolledUnderElevation: 0,
                      actions: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.search)),
                        IconButton(
                            onPressed: () {
                              isList = !isList;
                              setState(() {});
                            },
                            icon: isList == true
                                ? const Icon(Icons.grid_view_sharp)
                                : const Icon(Icons.list))
                      ],
                    ),
                    data.isEmpty
                        ? const SliverAppBar(
                            title: Text("There is nothing!"),
                            leading: null,
                            centerTitle: true,
                          )
                        : isList == true
                            ? ListViewVariable(data: data)
                            : GridViewVariable(data: data),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const MainPageAdd(),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
