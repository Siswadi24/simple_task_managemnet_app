import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:managemen_task_app/common/theme.dart';

class NotifikasiScreen extends StatelessWidget {
  final String? label;
  const NotifikasiScreen({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.grey[600],
          ),
        ),
        title: Center(
          child: Text(
            this.label.toString().split("|")[0],
            style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.grey[600],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 30),
            child: Column(
              children: [
                Text(
                  "Hallo, Siswadi Perdana Putra",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "Kamu memiliki 1 pengingat baru loh !!!",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: MediaQuery.of(context).size.width,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Get.isDarkMode ? Colors.white : Colors.grey[600],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.title,
                            size: 20,
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Title',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 25,
                                color: Get.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        this.label.toString().split("|")[0],
                        style: TextStyle(
                            color:
                                Get.isDarkMode ? Colors.black : Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            size: 20,
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Description',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 25,
                                color: Get.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        this.label.toString().split("|")[1],
                        style: TextStyle(
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: Get.isDarkMode ? Colors.black : Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Date or Time',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 25,
                                color: Get.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        this.label.toString().split("|")[2],
                        style: TextStyle(
                            color:
                                Get.isDarkMode ? Colors.black : Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
