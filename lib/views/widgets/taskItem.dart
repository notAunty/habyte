import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/models/task.dart';
import 'package:intl/intl.dart';
import '../pages/tasks/_tasks.dart';

class TaskItem extends StatelessWidget {
  final Map<String, dynamic> task;
  final Function(Map<String, dynamic>)? delete;
  final Function(Map<String, dynamic>)? edit;

  const TaskItem({required this.task, this.delete, this.edit});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Card(
            color: WHITE_01, //Theme.of(context).colorScheme.onSurface,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task['name'],
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            DateFormat('yyyy-MM-dd').format(task['startDate']) +(task['endDate']==null? '' : ('-' +
                                DateFormat('yyyy-MM-dd').format(task['endDate']!)))
                               ,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        task['points'].toString(),
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: this.edit == null && this.delete==null 
                        ? Container()
                        : Column(
                            children: [
                              SizedBox(height: 8),
                              Divider(),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          edit!(task);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.edit),
                                            Text('Edit')
                                          ],
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          delete!(task);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete),
                                            Text('Delete')
                                          ],
                                        )),
                                  ]),
                            ],
                          ),
                  ),
                ],
              ),
            )));
  }
}
