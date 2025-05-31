import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_keeper/model/note_model.dart';
import 'package:provider/provider.dart';

import '../view_model/note_view_model.dart';

class NotesDetailsView extends StatefulWidget {
  NotesDetailsView({super.key});

  @override
  State<NotesDetailsView> createState() => _NotesDetailsViewState();
}

class _NotesDetailsViewState extends State<NotesDetailsView> {
  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();

  late NoteDetailArgument args;

  late NoteViewModel noteProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as NoteDetailArgument;
    noteProvider = Provider.of<NoteViewModel>(context);
    if (args.appBarTitle == "Edit Note") {
      _titleController.text = args.noteModel!.title;
      _descriptionController.text = args.noteModel!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    //final noteProvider = Provider.of<NoteViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(args.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
                title: DropdownButton(
                    items: noteProvider.priorityList.map((String dropDownItem) {
                      return DropdownMenuItem<String>(
                          value: dropDownItem, child: Text(dropDownItem));
                    }).toList(),
                    iconEnabledColor: Colors.indigo,
                    iconDisabledColor: Colors.white,
                    iconSize: 35,
                    value: noteProvider.priorityAsString(noteProvider.priority),
                    style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    onChanged: (selectedPriority) {
                      noteProvider.priorityAsInt(selectedPriority!);
                    })),
            SizedBox(
              height: 10,
            ),

            ///Title TextField
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                label: Text("Title"),
                labelStyle: TextStyle(color: Colors.indigo),
                hintText: "Enter Your Title",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.indigo, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.indigo, width: 4)),
              ),
            ),
            SizedBox(
              height: 40,
            ),

            ///Description TextField
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                label: Text("Description"),
                labelStyle: TextStyle(color: Colors.indigo),
                hintText: "Enter Your Description",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.indigo, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.indigo, width: 4)),
              ),
            ),
            SizedBox(
              height: 40,
            ),

            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ///SAVE Button
              Container(
                width: 150,
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.indigo)),
                    onPressed: () async {
                      String time = DateFormat.yMMMd().format(DateTime.now());
                      if (args.appBarTitle == "Add Note") {
                        NoteModel noteModel = NoteModel(
                            priority: noteProvider.priority,
                            title: _titleController.text.trim(),
                            description: _descriptionController.text.trim(),
                            time: time);
                        await noteProvider.insertData(noteModel);
                      } else if (args.appBarTitle == "Edit Note") {
                        String title = _titleController.text;
                        String description = _descriptionController.text;
                        NoteModel noteModel = NoteModel(
                            id: args.noteModel!.id,
                            priority: noteProvider.priority,
                            title: title,
                            description: description,
                            time: time);
                        await noteProvider.updateNote(noteModel);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      args.buttonText,
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                width: 10,
              ),

              ///Deleted Button
              Container(
                width: 150,
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.indigo)),
                    onPressed: () {
                      if (args.appBarTitle == "Edit Note") {
                        noteProvider.deleteNote(args.noteModel!.id!);
                        Navigator.of(context).pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Note is not deleted')));
                      }
                    },
                    child: Text(
                      "DELETE",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

class NoteDetailArgument {
  String appBarTitle;
  NoteModel? noteModel;
  String buttonText;
  NoteDetailArgument(
      {required this.appBarTitle,
      required this.buttonText,
      this.noteModel});
}
