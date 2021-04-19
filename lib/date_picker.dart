import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateRangePickerController _controller = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SfDateRangePicker(
      controller: _controller,
      selectionColor: Colors.transparent,
      toggleDaySelection: true,
      allowViewNavigation: false,
      selectionMode: DateRangePickerSelectionMode.multiple,
      cellBuilder: (BuildContext context, DateRangePickerCellDetails details) {
        final now = DateTime.now();
        final currentDate = DateTime(now.year, now.month, now.day);
        final isToday = details.date == currentDate;
        final isPastDay = details.date.isBefore(currentDate);
        final isSelected = _controller.selectedDates?.contains(details.date) ?? false;

        return Container(
          margin: EdgeInsets.all(2),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double size = constraints.maxWidth;
            if (constraints.maxHeight < constraints.maxWidth) {
              size = constraints.maxHeight;
            }
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.red : null,
                    border: isToday
                        ? Border.all(color: Colors.purple, width: 1)
                        : null,
                  ),
                  child: Text(
                    details.date.day.toString(),
                    style: TextStyle(
                        color: isPastDay
                            ? theme.hintColor
                            : isSelected
                                ? Colors.white
                                : Colors.black),
                  ),
                ),
              ],
            );
          }),
        );
      },
      monthViewSettings: DateRangePickerMonthViewSettings(
        firstDayOfWeek: 1,
        dayFormat: 'EEE',
      ),
      showNavigationArrow: true,
      enablePastDates: false,
    );
  }
}
