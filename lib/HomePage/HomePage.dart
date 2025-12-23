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
        title: TextField(
          controller: titleController,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          decoration: const InputDecoration(border: InputBorder.none),
        ),
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (_, i) {
          final e = entries[i];
          return Card(
            child: ListTile(
              title: Text("${e.text} 🩷"),
              subtitle: Text("${e.done}/${e.total}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (e.done > 0) e.done--;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        if (e.done < e.total) e.done++;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}