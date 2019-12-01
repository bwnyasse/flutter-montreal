import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_deep_dive_test/src/blocs/app_event.dart';
import 'package:flutter_movie_deep_dive_test/src/blocs/blocs.dart';
import 'package:flutter_movie_deep_dive_test/src/widgets/widgets.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppBloc>(context).add(FetchEvent());
  }

  Drawer _buildDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                child: Image.asset(
                  "assets/flutter-montreal.jpeg",
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Text(widget.title),
                        Image.asset('assets/canada.png'),
          ],
        ),
      ),
      drawer: _buildDrawer(),
      body: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is AppLoaded) {
            // Nothing to do
          }
        },
        child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
          // Is Loading
          if (state is AppLoading) {
            return Center(child: CircularProgressIndicator());
          }

          // Is Loaded
          if (state is AppLoaded) {
            return MoviesList(response: state.response);
          }

          // State error
          if (state is AppError) {
            return Text(
              'Something went wrong!',
              style: TextStyle(color: Colors.red),
            );
          }
          return Center(child: Text('Wait ...'));
        }),
      ),
    );
  }
}
