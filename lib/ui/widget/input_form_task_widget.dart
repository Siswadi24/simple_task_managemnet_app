import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:managemen_task_app/common/theme.dart';

class MyInputFormWidget extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputFormWidget({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  });

  @override
  State<MyInputFormWidget> createState() => _MyInputFormWidgetState();
}

class _MyInputFormWidgetState extends State<MyInputFormWidget> {
  late bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TitleStyle,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 10),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    obscureText:
                        widget.title == 'Password' ? _isObscureText : false,
                    readOnly: widget.widget == null ? false : true,
                    autofocus: false,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[200] : Colors.grey[700],
                    controller: widget.controller,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      suffixIcon: widget.title == "Password"
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscureText = !_isObscureText;
                                });
                              },
                              icon: _isObscureText
                                  ? SvgPicture.asset(
                                      "assets/images/eye.svg",
                                      color: Get.isDarkMode ? white : black,
                                    )
                                  : SvgPicture.asset(
                                      "assets/images/eyeSlash.svg",
                                      color: Get.isDarkMode ? white : black,
                                    ),
                            )
                          : null,
                      hintText: widget.hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.backgroundColor,
                          width: 0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.backgroundColor,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                widget.widget == null
                    ? Container()
                    : Container(
                        child: widget.widget,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
