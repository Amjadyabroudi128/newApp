import 'package:flutter/material.dart';

import '../models/entry.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController =
  TextEditingController(text: "💖 WEDNESDAY 💖");



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
              title: Text(e.text),
              subtitle: GestureDetector(
                onTap: () => _editNumberDialog(e),
                child: Row(
                  children: [
                    Text(
                      "${e.done}/${e.total}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 9,),
                    if(e.done >= e.total) FaIcon(FontAwesomeIcons.crosshairs,color: Colors.red,)
                  ],
                ),
              ),

            ),
          );
        },
      ),
    );
  }
  Future<void> _editNumberDialog(Entry e) async {
    final doneController =
    TextEditingController(text: e.done.toString());
    final totalController =
    TextEditingController(text: e.total.toString());

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit numbers"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: doneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Done"),
              ),
              TextField(
                controller: totalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Total"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Save"),
            ),
          ],
        );
      },
    );

    if (result != true) return;
    final newDone = int.tryParse(doneController.text.trim()) ?? e.done;
    final newTotal = int.tryParse(totalController.text.trim()) ?? e.total;

    setState(() {
      e.total = newTotal;
      e.done = newDone;
    });
  }

}