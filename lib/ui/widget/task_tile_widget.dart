import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managemen_task_app/common/theme.dart';
import 'package:managemen_task_app/models/task_model.dart';

class TaskTileWidget extends StatelessWidget {
  final TaskModel? taskModel;
  TaskTileWidget(
    this.taskModel,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 15),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: _getBGClr(taskModel?.color ?? 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel?.title ?? "",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${taskModel!.startTime} - ${taskModel!.endTime}',
                        style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(fontSize: 12, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    taskModel?.note ?? "",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.5),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                taskModel?.isComplete == 1 ? "SELESAI" : "DIKERJAKAN",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_getBGClr(int no) {
  switch (no) {
    case 0:
      return Colors.green;
    case 1:
      return pinkClr;
    case 2:
      return bluishClr;
    default:
      return yellowClr;
  }
}
