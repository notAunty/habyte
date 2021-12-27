import 'package:flutter/material.dart';
import 'package:habyte/views/constant/colors.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final Map<String, dynamic> task;
  final Function? delete;
  final Function? edit;

  const TaskCard({Key? key, required this.task, this.delete, this.edit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Card(
        color: WHITE_01, //Theme.of(context).colorScheme.onSurface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
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
                          task[TASK_NAME],
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        DateFormat('yyyy-MM-dd').format(task[TASK_START_DATE]) +
                            (task[TASK_END_DATE] == null
                                ? ''
                                : ('-' +
                                    DateFormat('yyyy-MM-dd')
                                        .format(task[TASK_END_DATE]!))),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        task[TASK_POINTS].toString(),
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'pts',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                child: edit == null && delete == null
                    ? Container()
                    : StatefulBuilder(builder: (context, setState) {
                        return Column(
                          children: [
                            const SizedBox(height: 8),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    edit!(task, setState);
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(Icons.edit),
                                      SizedBox(width: 4),
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
                                      SizedBox(width: 4),
                                      Text('Delete')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
