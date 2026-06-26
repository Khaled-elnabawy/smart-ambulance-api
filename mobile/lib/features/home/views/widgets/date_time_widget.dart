import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/theming/styles.dart';

import '../../../../core/helpers/spacing.dart';

class DateTimeWidget extends StatefulWidget {
  final Function(String?, String?) onDateTimeChanged;

  const DateTimeWidget({super.key, required this.onDateTimeChanged});

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? timeText;
  String? dateText;

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateText = selectedDate == null
            ? "Select Date"
            : DateFormat('yyyy-MM-dd').format(selectedDate!);
      });
      widget.onDateTimeChanged(timeText, dateText);
    }
  }

  Future<void> pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
        timeText = selectedTime == null
            ? "Select Time"
            : '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}:00';
      });
      widget.onDateTimeChanged(timeText, dateText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: buildField(
            title: "Date",
            value: dateText??"Select Date",
            icon: Icons.calendar_today,
            onTap: pickDate,
          ),
        ),
        horizontalSpacing(16),
        Expanded(
          child: buildField(
            title: "Time",
            value: timeText??"Select Time",
            icon: Icons.access_time,
            onTap: pickTime,
          ),
        ),
      ],
    );
  }

  Widget buildField({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.font16BlackRegular),
        verticalSpacing(8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: value.contains("Select")
                          ? Colors.grey
                          : Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                horizontalSpacing(8),
                Icon(icon, color: Colors.red),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
