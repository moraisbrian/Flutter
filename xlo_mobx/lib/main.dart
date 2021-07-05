import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';
import 'parse_server_credentials.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ParseServerCredentials.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO MobX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: BaseScreen(),
    );
  }
}
