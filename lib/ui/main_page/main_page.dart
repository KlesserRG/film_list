import 'package:film_list/domain/bloc/film_list_bloc.dart';
import 'package:film_list/ui/main_page/grid_view_variable.dart';
import 'package:film_list/ui/main_page/list_view_variable.dart';
import 'package:film_list/ui/main_page/main_page_add.dart';
import 'package:film_list/ui/main_page/main_page_drawer.dart';
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
        return Scaffold(
          appBar: AppBar(
            title: const Text("Film List"),
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.adb_rounded))
            ],
          ),
          // drawer: const MainPageDrawer,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: const SizedBox(),
                floating: true,
                surfaceTintColor: Colors.transparent,
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const MainPageAdd(),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
