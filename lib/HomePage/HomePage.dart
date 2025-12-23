import 'package:flutter/material.dart';

import '../models/entry.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController =
  TextEditingController(text: "💖 WEDNESDAY 💖");

  final List<Entry> entries = [
    Entry("SAINS - L.A", 0, 4),
    Entry("C👀P - Kingsway", 0, 4),
    Entry("B👀TS - Reigate", 2, 4),
    Entry("C👀P - Southwater", 0, 4),
    Entry("COUNTY MALL - Crawley", 1, 4),
    Entry("WELCOME - Lancing", 0, 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello guys "),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
                "This is a new app "
            ),
          ],
        ),
      ),

    );
  }
}