import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_movie_deep_dive_test/src/app.dart';
import 'package:flutter_movie_deep_dive_test/src/providers/providers.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import '../test/src/common.dart';

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // TODO 1- Explain why use of mock in this integration test
  final mockClient = MockClient((request) async {
    return Response(json.encode(exampleJsonResponse2), 200);
  });

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  runApp(AppProvider(
    httpClient: mockClient,
    child: MyApp(),
  ));
}
