import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_deep_dive_test/src/blocs/blocs.dart';
import 'package:flutter_movie_deep_dive_test/src/services/services.dart';
import 'package:flutter_movie_deep_dive_test/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Montreal',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        builder: (context) => AppBloc(
          service: Provider.of<AppService>(
            context,
            listen: false,
          ),
        ),
        child: MyHomePage(title: 'Movies - Flutter Montreal'),
      ),
    );
  }
}
