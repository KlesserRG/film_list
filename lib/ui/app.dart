import 'package:film_list/domain/bloc/film_list/film_list_bloc.dart';
import 'package:film_list/ui/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FilmListBloc()..add(const FilmListLoad()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        home: const MainPage(),
      ),
    );
  }
}
