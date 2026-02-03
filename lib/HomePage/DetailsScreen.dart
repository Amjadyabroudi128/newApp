import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:to_be_named/components/kTextField.dart';
import 'package:to_be_named/core/Colors.dart';
import 'package:to_be_named/core/icons.dart';
import 'package:to_be_named/core/textStlyes.dart';

import '../components/myToast.dart';
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
          crossAxisAlignment: .start,
          children: [
            Text(
              dayName.toUpperCase(),
              style: MyTextStyles.dayName,
            ),
            Text(
              dateFormatted,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: .normal,
              ),
            ),
          ],
        ),
      ),
      body: entries.isEmpty
          ?  Center(
        child: Text(
          'No entries for this day',
          style: MyTextStyles.empty,
        ),
      )
          : ListView.builder(
        itemCount: entries.length,
        itemBuilder: (_, i) {
          return Card(
            child: ListTile(
              title: GestureDetector(
                child: Text(entries[i].text),
                onTap: () => editPlaceName(entries[i])
              ),
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
                    if(entries[i].done >= entries[i].total) FaIcon(FontAwesomeIcons.crosshairs,color: MyColors.crossHair)
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEntry,
        child: MyIcons.addBtn,
      ),
    );
  }
  Future<void> editPlaceName(Entry e) async {
    final namePlace = TextEditingController(text: e.text.toString());
    await showDialog(context: context,
      builder: (context) {
      return AlertDialog(
        title: const Text("Edit place"),
        content: MyField(
          myController: namePlace,
          myDecoration: const InputDecoration(labelText: "Place name"),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          GestureDetector(
            onTap: () {
              final newText = namePlace.text.trim();
              if(newText.isEmpty) {
                myToast("Can't be empty");
              } else if (newText == e.text) {
                myToast("please edit it");
              } else {
                setState(() {
                  e.text = newText;
                });
              }
              Navigator.pop(context, true);
            },
            child: Text(
              "Save",
              style: TextStyle(color: MyColors.save),
            ),
          ),

        ],
      );
      }
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
          content: MyField(
            myController: textController,
            myDecoration: const InputDecoration(labelText: "Place text"),
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.pop(context, false),
              child: Text("Cancel"),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: Text("Save", style: TextStyle(color: MyColors.save),),
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
            mainAxisSize: .min,
            children: [
              MyField(
                myController: doneController,
                type: .number,
                myDecoration: const InputDecoration(labelText: "Done"),
              ),
              MyField(
                myController: totalController,
                type: .number,
                myDecoration: const InputDecoration(labelText: "Total"),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.pop(context, false),
              child: Text("Cancel"),
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: Text("Save", style: TextStyle(color: MyColors.save),),
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
