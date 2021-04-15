import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/journal_model.dart';
import 'package:working_project/app/providers/journal_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/utils/snack_bar.dart';
import 'package:working_project/app/view/journal/edit_journal_page.dart';

//TODO: Remove Slidable
//TODO: Empty Screen
class BuildJournal extends StatelessWidget {
  final Function getInitialData;

  const BuildJournal({Key key, this.getInitialData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SharedPrefs prefs = SharedPrefs();
    final List<JournalModel> journals =
        Provider.of<JournalProvider>(context, listen: true).journalModels;
    final JournalProvider journalProvider =
        Provider.of<JournalProvider>(context, listen: true);
    return ListView(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemCount: journals.length,
          itemBuilder: (context, int index) {
            final JournalModel journal = journals[index];
            //formatting date
            var date = DateTime.parse(journal.createdDate);
            var formattedDate = '${date.day}/${date.month}/${date.year}';
            //slidable widget for delete and edit
            return ClipRRect(
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                key: Key(journal.journalID.toString()),
                actions: [
                  IconSlideAction(
                      color: Colors.deepOrangeAccent,
                      //edit function call
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditJournal(
                                journal: journal,
                              ),
                            ),
                          ).then((_) {
                            getInitialData();
                          }),
                      caption: 'Edit',
                      icon: Icons.edit)
                ],
                secondaryActions: [
                  IconSlideAction(
                    color: Colors.red,
                    caption: 'Delete',
                    //delete function call
                    onTap: () async {
                      final String userID = await prefs.readUserID();
                      await journalProvider
                          .deleteJournal(
                              userID: userID, journalID: journal.journalID)
                          .then((value) {
                        getInitialData();
                        showSnackBar(
                            context, 'Deleted ${journal.title}', Colors.red);
                      });
                    },
                    icon: Icons.delete,
                  )
                ],
                child: ListTile(
                  //onTap showing edit page(details)
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditJournal(
                          journal: journal,
                        ),
                      ),
                    ).then((_) {
                      getInitialData();
                    });
                  },
                  title: Text(journal.title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.indigo)),
                  subtitle: Container(
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text(journal.subtitle)),
                        Container(
                            alignment: Alignment.topLeft,
                            child: Text('Created: $formattedDate')),
                      ],
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
