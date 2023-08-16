import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:managemen_task_app/common/theme.dart';
import 'package:managemen_task_app/controllers/task_controller.dart';
import 'package:managemen_task_app/models/task_model.dart';
import 'package:managemen_task_app/ui/widget/buttom_widget.dart';
import 'package:managemen_task_app/ui/widget/input_form_task_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('HH:mm').format(DateTime.now()).toString();
  String _endTime = '23:59';

  int _selectedReminder = 5;
  List<int> reminderList = [
    5,
    10,
    15,
    20,
    30,
  ];

  String _selectedRepeat = "None Repeat";
  List<String> repeatList = [
    "None Repeat",
    "Daily",
    "Weekly",
    "Monthly",
  ];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: HeadingStyle,
              ),
              MyInputFormWidget(
                title: 'Title',
                hint: 'Enter Your Title',
                controller: _titleController,
              ),
              MyInputFormWidget(
                title: 'Note',
                hint: 'Enter Your Note',
                controller: _noteController,
              ),
              MyInputFormWidget(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                    print('pick date');
                  },
                  icon: Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputFormWidget(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                          print('pick time');
                        },
                        icon: Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MyInputFormWidget(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                          print('pick time');
                        },
                        icon: Icon(
                          Icons.access_time,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              MyInputFormWidget(
                title: 'Reminder',
                hint: "$_selectedReminder minutes lebih awal",
                widget: DropdownButton(
                  padding: EdgeInsets.only(right: 10),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 20,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedReminder = int.parse(newValue!);
                    });
                  },
                  items:
                      reminderList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              MyInputFormWidget(
                title: 'Repeat Reminder',
                hint: "$_selectedRepeat",
                widget: DropdownButton(
                  padding: EdgeInsets.only(right: 10),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 20,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value!,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalletePicker(),
                  MyButtonWidget(
                    label: "Buat Task",
                    onTap: () {
                      _validateDate();
                      print('Buat Task');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      // Todo: Tambah ke database
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "Isi semua form !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.white : Colors.red,
        colorText: Get.isDarkMode ? pinkClr : Colors.white,
        icon: Get.isDarkMode
            ? Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
              )
            : Icon(
                Icons.warning_amber_rounded,
                color: Colors.white,
              ),
      );
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
      taskModel: TaskModel(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        reminder: _selectedReminder,
        repeatRemind: _selectedRepeat,
        color: _selectedColor,
        isComplete: 0,
      ),
    );
    print("Id saya adalah " + "$value");
  }

  _colorPalletePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: TitleStyle,
        ),
        SizedBox(height: 7.0),
        Wrap(
          children: List<Widget>.generate(4, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                  print(index);
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: index == 0
                      ? Colors.green
                      : index == 1
                          ? pinkClr
                          : index == 2
                              ? bluishClr
                              : yellowClr,
                  child: _selectedColor == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 15,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/profile.png'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.black,
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print('Date is not selected');
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    // TimeOfDay _formatedTime = pickedTime.format(context);

    if (pickedTime == null) {
      print('Time is Cancelled');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
        // _startTime = _formatedTime.format(context);
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
        // _endTime = _formatedTime.format(context);
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      // initialTime: TimeOfDay(
      //   hour: int.parse(_startTime.split(':')[0]),
      //   minute: int.parse(_startTime.split(':')[1].split(' ')[0]),
      // ),
      initialTime: TimeOfDay.fromDateTime(
        DateFormat('HH:mm').parse(_startTime),
      ),
    );
  }
}
