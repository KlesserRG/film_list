import 'package:film_list/domain/bloc/film_list/film_list_bloc.dart';
import 'package:film_list/ui/main_page/grid_view_variable.dart';
import 'package:film_list/ui/main_page/list_view_variable.dart';
import 'package:film_list/ui/main_page/main_page_add.dart';
import 'package:film_list/ui/main_page/main_page_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const <Widget>[
        MainPageBackground(),
        MainPageFrontground(),
      ],
    );
  }
}

class MainPageBackground extends StatelessWidget {
  const MainPageBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
            Colors.pinkAccent,
            Colors.deepPurpleAccent,
            Colors.blue,
          ],
        ),
      ),
    );
  }
}

class MainPageFrontground extends StatefulWidget {
  const MainPageFrontground({
    super.key,
  });

  @override
  State<MainPageFrontground> createState() => _MainPageFrontgroundState();
}

class _MainPageFrontgroundState extends State<MainPageFrontground> {
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
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            Theme.of(context).canvasColor,
            BlendMode.srcOut,
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              scrolledUnderElevation: 0,
              title: const Text("Film List"),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.account_circle_outlined),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPageSearchBar(data: data),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
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
            body: CustomScrollView(
              slivers: <Widget>[
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
                  borderRadius: BorderRadius.circular(16)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const MainPageAdd(),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
