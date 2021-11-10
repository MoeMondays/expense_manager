import 'package:flutter/material.dart';
import 'package:project/pages/accounts_page.dart';
import 'package:project/pages/detail_page.dart';
import 'package:project/pages/new_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        AccountsPage.routeName: (context) => const AccountsPage(),
        DetailPage.routeName: (context) => const DetailPage(),
        NewDetailPage.routeName: (context) => const NewDetailPage(),
      },
      initialRoute: AccountsPage.routeName,
    );
  }
}