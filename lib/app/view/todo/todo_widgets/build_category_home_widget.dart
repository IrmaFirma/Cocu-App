import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:working_project/app/models/category_todo_model.dart';
import 'package:working_project/app/providers/category_todo_provider.dart';
import 'package:working_project/app/view/todo/todo_page.dart';

class BuildCategoryHome extends StatefulWidget {
  final Function getInitialData;

  const BuildCategoryHome({@required this.getInitialData});

  @override
  _BuildCategoryHomeState createState() => _BuildCategoryHomeState();
}

class _BuildCategoryHomeState extends State<BuildCategoryHome> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    final List<CategoryTodoModel> categories =
        Provider.of<CategoryTodoProvider>(context, listen: true).categoryModels;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TableCalendar(
            startingDayOfWeek: StartingDayOfWeek.monday,
            initialCalendarFormat: CalendarFormat.week,
            headerStyle: HeaderStyle(
              formatButtonShowsNext: false,
            ),
            calendarStyle: CalendarStyle(
                weekendStyle: TextStyle(color: Colors.grey.shade700),
                weekdayStyle: TextStyle(color: Colors.grey.shade700),
                todayColor: Color(0xFF6FCED5),
                selectedColor: Color(0xFF6FCED5),
                todayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white)),
            calendarController: _calendarController),
        Padding(
          padding: EdgeInsets.only(left: width / 25, right: width / 25),
          child: Container(
            height: 75,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 1.5,
              child: ListTile(
                title: Text('Today\'s Tasks'),
                subtitle: Text('For today 8'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              categories.isEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height / 10),
                          child: Container(
                              height: height / 5,
                              width: width / 2,
                              child: Image.asset('assets/list.png')),
                        ),
                        SizedBox(
                          height: height / 55,
                        ),
                        Text(
                          'No lists yet',
                          style: TextStyle(
                              fontFamily: 'Varela', fontSize: width / 15),
                        ),
                        Text('Start creating and changing your life',
                            style: TextStyle(
                                fontFamily: 'Varela', fontSize: width / 25)),
                      ],
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      primary: true,
                      itemCount: categories.length,
                      itemBuilder: (context, int index) {
                        final CategoryTodoModel category = categories[index];
                        return ClipRRect(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: width / 25, right: width / 25),
                                  child: Container(
                                    height: 75,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      elevation: 1.5,
                                      shadowColor: Color(0xFFced1d6),
                                      child: ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TodoPage(
                                                            categoryID: category
                                                                .categoryID)));
                                          },
                                          title: Wrap(
                                            children: [
                                              Text(
                                                category.categoryTitle,
                                                style: TextStyle(
                                                  fontSize: width / 24,
                                                  fontFamily: 'Valera',
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF2B2B2B),
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Text(
                                            category.categoryNote,
                                            style:
                                                TextStyle(fontSize: width / 30),
                                          ),
                                          trailing:
                                              Icon(Icons.arrow_forward_ios)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
            ],
          ),
        ),
      ],
    );
  }
}
