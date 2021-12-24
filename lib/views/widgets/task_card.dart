import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final Map<String, dynamic> task;
  final Function(Map<String, dynamic>)? delete;
  final Function(Map<String, dynamic>)? edit;

  const TaskCard({Key? key, required this.task, this.delete, this.edit})
      : super(key: key);

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
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Card(
        color: WHITE_01, //Theme.of(context).colorScheme.onSurface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          task['name'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        DateFormat('yyyy-MM-dd').format(task['startDate']) +
                            (task['endDate'] == null
                                ? ''
                                : ('-' +
                                    DateFormat('yyyy-MM-dd')
                                        .format(task['endDate']!))),
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
                child: edit == null && delete == null
                    ? Container()
                    : Column(
                        children: [
                          const SizedBox(height: 8),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  edit!(task);
                                },
                                child: Row(
                                  children: const [
                                    Icon(Icons.edit),
                                    Text('Edit')
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  delete!(task);
                                },
                                child: Row(
                                  children: const [
                                    Icon(Icons.delete),
                                    Text('Delete')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
