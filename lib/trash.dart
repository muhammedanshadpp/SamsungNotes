import 'package:flutter/material.dart';

class haha {
  final String title;
  final String body;

  haha({required this.title, required this.body});
}

class hiihihi extends StatelessWidget {
  final ValueNotifier<List<haha>> notesNotifier = ValueNotifier([
    haha(title: "Note 1", body: "This is the body of note 1"),
    haha(title: "Note 2", body: "This is the body of note 2"),
    haha(title: "Note 3", body: "This is the body of note 3"),
  ]);

  final ValueNotifier<List<haha>> deletedNotesNotifier = ValueNotifier([]);

  void moveToRecycleBin(int index) {
    // Get the note to move
    final noteToMove = notesNotifier.value[index];
    print("Note to move: $noteToMove");

    // Add it to the deleted list
    deletedNotesNotifier.value = [
      ...deletedNotesNotifier.value,
      noteToMove,
    ];
    print("Deleted Notes Notifier: ${deletedNotesNotifier.value}");

    // Remove it from the main list
    final updatedNotesList = List<haha>.from(notesNotifier.value);
    updatedNotesList.removeAt(index);
    notesNotifier.value = updatedNotesList;
    print("Updated Notes List: ${notesNotifier.value}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<haha>>(
              valueListenable: notesNotifier,
              builder: (context, notesList, _) {
                return ListView.builder(
                  itemCount: notesList.length,
                  itemBuilder: (context, index) {
                    final note = notesList[index];
                    return ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.body),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          moveToRecycleBin(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Divider(),
          Text(
            "Recycle Bin",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ValueListenableBuilder<List<haha>>(
              valueListenable: deletedNotesNotifier,
              builder: (context, deletedList, _) {
                return ListView.builder(
                  itemCount: deletedList.length,
                  itemBuilder: (context, index) {
                    final note = deletedList[index];
                    return ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.body),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
