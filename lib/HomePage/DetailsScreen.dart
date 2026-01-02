import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:to_be_named/components/kTextBtn.dart';
import 'package:to_be_named/components/kTextField.dart';

import '../models/entry.dart';

class DayDetailsScreen extends StatefulWidget {
  final DateTime selectedDate;

  const DayDetailsScreen({super.key, required this.selectedDate});

  @override
  State<DayDetailsScreen> createState() => _DayDetailsScreenState();
}

class _DayDetailsScreenState extends State<DayDetailsScreen> {
  List<Entry> entries = [];

  @override
  Widget build(BuildContext context) {
    // Format the date to show day name and date
    final dayName = DateFormat('EEEE').format(widget.selectedDate);
    final dateFormatted = DateFormat('MMM dd, yyyy').format(widget.selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dayName.toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              dateFormatted,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: entries.isEmpty
          ? const Center(
        child: Text(
          'No entries for this day',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: entries.length,
        itemBuilder: (_, i) {
          return Card(
            child: ListTile(
              title: Text(entries[i].text),
              subtitle: GestureDetector(
                onTap: () => _editNumberDialog(entries[i]),
                child: Row(
                  children: [
                    Text(
                      "${entries[i].done}/${entries[i].total}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 9),
                    if(entries[i].done >= entries[i].total) FaIcon(FontAwesomeIcons.crosshairs,color: Colors.red,)
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addEntry() async {
    final textController = TextEditingController();

    final result = await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: .spaceAround,
          title: const Text("Add Place"),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(labelText: "Place text"),
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.pop(context, false),
              child: Text("Cancel"),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: Text("Save"),
            ),
          ],
        );
      },
    );

    if (result != true) return;
    final text = textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      entries.add(Entry( text,0,4));
    });
  }

  Future<void> _editNumberDialog(Entry e) async {
    final doneController = TextEditingController(text: e.done.toString());
    final totalController = TextEditingController(text: e.total.toString());

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit target"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyField(
                myController: doneController,
                type: TextInputType.number,
                myDecoration: const InputDecoration(labelText: "Done"),
              ),
              MyField(
                myController: totalController,
                type: TextInputType.number,
                myDecoration: const InputDecoration(labelText: "Total"),
              ),
            ],
          ),
          actions: [
            MyTextBtn(
              pressMe: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            MyTextBtn(
              pressMe: () => Navigator.pop(context, true),
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
