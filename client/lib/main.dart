import 'package:apps/api/vacination_api.dart';
import 'package:apps/pages/filter_widget.dart';
import 'package:apps/pages/home.dart';
import 'package:apps/pages/home/home_bloc.dart';
import 'package:apps/pages/home/home_event.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void main() async {
  Intl.defaultLocale = 'pt_BR';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeBloc = HomeBloc(VacinationAPI());
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Georgia',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dados Covid-19'),
          actions: <Widget>[
            Row(mainAxisSize: MainAxisSize.min, children: [
              FilterWidget(
                bloc: homeBloc,
              )
            ])
          ],
        ),
        body: BlocProvider(
          create: (context) => homeBloc..add(FetchHomeDataEvent("ALL")),
          child: HomePage(),
        ),
      ),
    );
  }
}
