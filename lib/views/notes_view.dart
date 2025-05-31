import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../utils/routes/name_route.dart';
import '../view_model/note_view_model.dart';
import 'notes_details_view.dart';

class NoteView extends StatefulWidget {
  NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Note View"), centerTitle: true),
      body: noteProvider.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : noteProvider.errorText != null
              ? Center(child: Text("ERROR: ${noteProvider.errorText}"))
              : noteProvider.noteList.isEmpty
                  ? Center(
                      child: Text(
                        "No Note is found.",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: noteProvider.noteList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                RoutesName.noteDetailView,
                                arguments: NoteDetailArgument(
                                    appBarTitle: "Edit Note",
                                    noteModel: noteProvider.noteList[index],
                                    buttonText: "UPDATE"));
                          },
                          child: Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    noteProvider.noteList[index].priority == 1
                                        ? Colors.red
                                        : Colors.amber,
                                child: Icon(
                                    noteProvider.noteList[index].priority == 1
                                        ? Icons.play_arrow
                                        : Icons.keyboard_arrow_right),
                              ),
                              title: Text(noteProvider.noteList[index].title),
                              subtitle: Text(noteProvider.noteList[index].time),
                              trailing: IconButton(
                                  onPressed: () {
                                    noteProvider.deleteNote(
                                        noteProvider.noteList[index].id!);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.indigo,
                                    size: 30,
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: FloatingActionButton(
          backgroundColor: Colors.indigo,
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamed(RoutesName.noteDetailView,arguments: NoteDetailArgument(appBarTitle: "Add Note",buttonText: "SAVE"));

          },
        ),
      ),
    );
  }
}
