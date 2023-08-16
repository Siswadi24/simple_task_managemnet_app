import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:managemen_task_app/common/theme.dart';
import 'package:managemen_task_app/controllers/sign_up_controller.dart';
import 'package:managemen_task_app/controllers/task_controller.dart';
import 'package:managemen_task_app/models/task_model.dart';
import 'package:managemen_task_app/service/notification_service.dart';
import 'package:managemen_task_app/service/theme_service.dart';
import 'package:managemen_task_app/ui/add_task_screen.dart';
import 'package:managemen_task_app/ui/widget/buttom_widget.dart';
import 'package:managemen_task_app/ui/widget/task_tile_widget.dart';

import '../models/signup_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _taskController = Get.put(TaskController());
  final _signUpController = Get.put(SignUpController());
  DateTime _selectedDate = DateTime.now();
  String? _userEmail; // Tambahkan variabel userEmail
  SignUpModel? _userData;
  var notificationHelper;

  @override
  void initState() {
    super.initState();
    notificationHelper = NotificationHelper();
    notificationHelper.initializeNotification();
    notificationHelper.requestNotificationPermission();

    // if (_signUpController.dataUser.isNotEmpty) {
    //   _userEmail = _signUpController.dataUser[0].email;
    //   _signUpController.fetchUserData(_userEmail!);
    // } else {
    //   debugPrint('Data Kosong');
    // }

    setState(() {
      print('Saya Disini');
      _taskController.getAllTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Build Method Called');
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskButton(),
          _addDateBar(),
          const SizedBox(
            height: 15,
          ),
          _showTask(),
        ],
      ),
    );
  }

  _showTask() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
              itemCount: _taskController.taskList.length,
              itemBuilder: (_, index) {
                print(_taskController.taskList.length);
                TaskModel taskModel = _taskController.taskList[index];
                print(taskModel.toJson());
                if (taskModel.repeatRemind == 'Daily') {
                  // String formattedStartTime =
                  //     '${taskModel.startTime} ${taskModel.endTime}';
                  // DateTime dateTime = DateFormat('hh:mm a').parseLoose(
                  //     '${taskModel.startTime} ${taskModel.endTime}');

                  //###
                  // DateTime dateTime = DateFormat('hh:mm a')
                  //     .parseLoose(taskModel.startTime.toString());
                  // var myTime = DateFormat('HH:mm').format(dateTime);
                  // DateTime now = DateTime.now();
                  // DateTime scheduledTime = DateTime(
                  //     now.year,
                  //     now.month,
                  //     now.day,
                  //     int.parse(myTime.split(":")[0]),
                  //     int.parse(myTime.split(":")[1]));

                  //##
                  DateTime dateTime = DateFormat.jm()
                      .parseLoose(taskModel.startTime.toString());
                  var myTime = DateFormat('HH:mm').format(dateTime);

                  notificationHelper.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]), //hour
                    int.parse(
                        myTime.toString().split(":")[1].split(' ')[0]), //minute
                    taskModel,
                  );
                  print("ini waktukuuuuuuuu ${myTime}");
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1000),
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('Tapped ShowButtomSheet');
                                _showBottomSheet(
                                  context,
                                  taskModel,
                                );
                              },
                              child: TaskTileWidget(
                                taskModel,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (taskModel.date ==
                    DateFormat.yMd().format(_selectedDate)) {
                  //##
                  DateTime dateTime = DateFormat.jm()
                      .parseLoose(taskModel.startTime.toString());
                  var myTime = DateFormat('HH:mm').format(dateTime);

                  notificationHelper.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]), //hour
                    int.parse(
                        myTime.toString().split(":")[1].split(' ')[0]), //minute
                    taskModel,
                  );
                  print("ini waktukuuuuuuuu ${myTime}");
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1000),
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('Tapped ShowButtomSheet');
                                _showBottomSheet(
                                  context,
                                  taskModel,
                                );
                              },
                              child: TaskTileWidget(
                                taskModel,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              });
        },
      ),
    );
  }

  _showBottomSheet(BuildContext context, TaskModel taskModel) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 5),
        height: taskModel.isComplete == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Get.isDarkMode ? Colors.grey[700] : Colors.grey[400],
              ),
            ),
            Spacer(),
            taskModel.isComplete == 1
                ? Container()
                : _bottomSheetButton(
                    label: 'Task as Completed',
                    onTap: () {
                      _taskController.markTaskComplete(taskModel.id!);
                      Get.back();
                    },
                    clr: primaryClr,
                    context: context,
                  ),
            _bottomSheetButton(
              label: 'Delete Task',
              onTap: () {
                _taskController.deleteTask(taskModel);
                Get.back();
              },
              clr: Colors.red[400]!,
              context: context,
            ),
            const SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
              label: 'Close',
              onTap: () {
                Get.back();
              },
              clr: Colors.white,
              isClose: true,
              context: context,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[400]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(15),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? TitleStyle : TitleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        onDateChange: (selectedDate) {
          setState(() {
            _selectedDate = selectedDate;
          });
        },
      ),
    );
  }

  _addTaskButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  'Today',
                  style: HeadingStyle,
                )
              ],
            ),
          ),
          MyButtonWidget(
            label: '+ Tambah Task',
            onTap: () async {
              await Get.to(() => const AddTaskScreen());
              _taskController.getAllTask();
              // await Get.to(AddTaskScreen());
            },
          ),
        ],
      ),
    );
  }

  _appBar() {
    // final resultUser = _signUpController.dataUser.length;
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notificationHelper.displayNotification(
              title: "You change your theme",
              body: Get.isDarkMode
                  ? "Active light Theme !"
                  : "Actived Dark Theme !");
          // notificationHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage(
            _userData == 'Laki-laki'
                ? 'assets/images/profile.png'
                : 'assets/images/woman.png',
          ),
          backgroundColor: Colors.green,
          foregroundColor: Colors.black,
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
