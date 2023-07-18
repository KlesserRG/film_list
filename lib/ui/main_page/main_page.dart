import 'package:film_list/domain/bloc/film_list/film_list_bloc.dart';
import 'package:film_list/ui/main_page/grid_view_variable.dart';
import 'package:film_list/ui/main_page/list_view_variable.dart';
import 'package:film_list/ui/main_page/main_page_add.dart';
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
        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
            flexibleSpace: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).canvasColor,
                BlendMode.srcOut,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.account_circle_outlined),
                        ),
                        const SizedBox(),
                        const Text(
                          "Film List",
                          style: TextStyle(fontSize: 24),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
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
                        )
                      ],
                    ),
                    const SizedBox(height: 8)
                  ],
                ),
              ),
            ),
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
            backgroundColor: Colors.blue,
            elevation: 0,
            // shape: RoundedRectangleBorder(
            //     side: const BorderSide(),
            //     borderRadius: BorderRadius.circular(16)),
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
