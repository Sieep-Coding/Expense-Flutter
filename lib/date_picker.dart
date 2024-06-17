import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final ValueChanged<DateTime>? onDateSelected;

  const DatePickerWidget({super.key, this.onDateSelected});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.teal,
              onPrimary: Colors.white,
              surface: Colors.grey,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected?.call(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        'Select Date',
        style: TextStyle(color: Colors.white),
      ),
      trailing: Text(
        _selectedDate.toString().split(' ')[0],
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () => _selectDate(context),
    );
  }
}
