import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/theming/styles.dart';

class DateTimeWidget extends StatefulWidget {
  final Function(DateTime?, TimeOfDay?) onDateTimeChanged;

  const DateTimeWidget({super.key, required this.onDateTimeChanged});

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

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
      });
      widget.onDateTimeChanged(selectedDate, selectedTime);
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
      });
      widget.onDateTimeChanged(selectedDate, selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    String dateText = selectedDate == null
        ? "Select Date"
        : DateFormat('dd, MMM, yyyy').format(selectedDate!);

    String timeText = selectedTime == null
        ? "Select Time"
        : selectedTime!.format(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildField(
          title: "Date",
          value: dateText,
          icon: Icons.calendar_today,
          onTap: pickDate,
        ),
        buildField(
          title: "Time",
          value: timeText,
          icon: Icons.access_time,
          onTap: pickTime,
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
        SizedBox(height: 8.h),
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
                Text(
                  value,
                  style: TextStyle(
                    color: value.contains("Select")
                        ? Colors.grey
                        : Colors.black,
                  ),
                ),
                SizedBox(width: 30.w),
                Icon(icon, color: Colors.red),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
