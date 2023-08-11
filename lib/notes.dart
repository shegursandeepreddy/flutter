import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController _notesController = TextEditingController();
  String _notes = '';

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notes = prefs.getString('notes') ?? '';
      _notesController.text = _notes;
    });
  }

  void _saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String notes = _notesController.text;
    await prefs.setString('notes', notes);
    setState(() {
      _notes = notes;
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextField(
                controller: _notesController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Write your notes here",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                _saveNotes();
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
