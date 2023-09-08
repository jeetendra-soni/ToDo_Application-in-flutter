import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/widget/task_widget.dart';

import '../data/firestore.dart';

class Stream_note extends StatelessWidget {
  final bool done;
  const Stream_note(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore_Datasource().stream(done),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                        backgroundColor: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text("Loading...", style: TextStyle(fontSize: 18, color: Colors.black54)),
                  ],
                ),
            );
          }
          final noteslist = Firestore_Datasource().getNotes(snapshot);
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final note = noteslist[index];
              return noteslist.length !=0
                  ? Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Delete Task ?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                          content: const Text("Are you sure you want to delete task?", style: TextStyle(fontSize: 16, color: Colors.black54),),
                          actionsAlignment: MainAxisAlignment.spaceAround,
                          actionsPadding: EdgeInsets.zero,
                          actions: <Widget>[
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                                Firestore_Datasource().delet_note(note.id);
                              },
                              child: const Text("Yes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: const Text("No", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                            ),
                          ]
                        ),
                    );
                    //
                  },
                  child: Task_Widget(note))
                  : Center(child: Text("No task available!"),);
            },
            itemCount: noteslist.length,
          );
        });
  }
}