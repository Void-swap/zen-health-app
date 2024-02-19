import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;
  final Icon? habitIcon;
  final String? habitDesc;
  // final Icon icon;

  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsTapped,
    required this.deleteTapped,
    required this.habitIcon,
    required this.habitDesc, // required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
         
            SlidableAction(
              onPressed: settingsTapped,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Card(
          color: Colors.grey[150],
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: ListTile(
              leading: Checkbox(
                value: habitCompleted,
                onChanged: onChanged,
              ),
              title: Text(habitName,
                  style: TextStyle(
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.bold)),
              subtitle: Text(habitDesc ?? "general habit desc",
                  style: TextStyle(color: Colors.blueGrey)),
              trailing: habitIcon ?? Icon(Icons.help),
            ),
          ),
        ),
      ),
    );
  }
}
