import 'package:flutter/material.dart';
import 'package:habyte/views/constant/constants.dart';
import 'package:habyte/views/constant/sizes.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    Key? key,
    required this.task,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  final Map<String, dynamic> task;
  final Function? onEdit;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: SIDE_PADDING / 4, horizontal: SIDE_PADDING),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BORDER_RADIUS)),
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          // padding: const EdgeInsets.symmetric(
          //   vertical: SIDE_PADDING / 1.5,
          //   horizontal: SIDE_PADDING,
          // ),
          padding: const EdgeInsets.fromLTRB(
            SIDE_PADDING,
            SIDE_PADDING / 1.5,
            SIDE_PADDING,
            SIDE_PADDING / 3,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task[TASK_NAME],
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('yyyy-MM-dd')
                                  .format(task[TASK_START_DATE]) +
                              (task[TASK_END_DATE] == null
                                  ? ''
                                  : (' -> ' +
                                      DateFormat('yyyy-MM-dd')
                                          .format(task[TASK_END_DATE]!))),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          task[TASK_POINTS].toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(width: 4),
                        const Text('pts')
                      ],
                    ),
                  )
                ],
              ),
              Container(
                child: onEdit == null && onDelete == null
                    ? Container()
                    : Column(
                        children: [
                          const SizedBox(height: 8),
                          const Divider(
                            thickness: 1.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () => onEdit!(
                                  context,
                                  task[TASK_ID],
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.edit),
                                    SizedBox(width: 4),
                                    Text('Edit')
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () => onDelete!(
                                  context,
                                  task[TASK_ID],
                                ),
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
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
