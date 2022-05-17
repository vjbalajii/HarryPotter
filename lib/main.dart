import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harry_potter/view/screens/home_screen.dart';
import 'package:harry_potter/view_model/character_view_model.dart';
import 'package:provider/provider.dart';

import 'model/repository/characters_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    CharactersRepository repo = CharactersRepositoryImpl();
    CharactersViewModel viewModel = CharactersViewModelImpl(repo: repo);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: viewModel),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Harry potter',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(),
          primarySwatch: Colors.purple,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
        },
      ),
    );
  }
}
