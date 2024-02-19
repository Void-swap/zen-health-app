import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:zen_health/screen/daily_planner/datetime/date_time.dart';

class ZenHeatMap extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String? startDate;

  const ZenHeatMap({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: HeatMap(
        startDate: createDateTimeObject(startDate ?? ''),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200],
        textColor: Colors.grey[200],
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 25,
        colorsets: const {
          1: Color.fromARGB(30, 140, 126, 255), // Lightest/MIN
          2: Color.fromARGB(60, 140, 126, 255),
          3: Color.fromARGB(90, 140, 126, 255),
          4: Color.fromARGB(120, 140, 126, 255),
          5: Color.fromARGB(150, 140, 126, 255),
          6: Color.fromARGB(180, 140, 126, 255),
          7: Color.fromARGB(210, 140, 126, 255),
          8: Color.fromARGB(235, 140, 126, 255),
          9: Color(0xFF8C7EFF),
          10: Color.fromRGBO(102, 90, 213, 1), // Darkest/MAX
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
