import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalsPage extends StatefulWidget {
  final String sectionToScroll;

  GoalsPage({required this.sectionToScroll});

  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final ScrollController _scrollController = ScrollController();

  // Global keys for each section
  final GlobalKey _sleepKey = GlobalKey();
  final GlobalKey _activityKey = GlobalKey();
  final GlobalKey _healthKey = GlobalKey();

  // Goal data
  int sleepGoal = 6; // Default values
  int stepsGoal = 10000;
  int activeMinutesGoal = 30;

  @override
  void initState() {
    super.initState();
    _loadGoalsData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSection(widget.sectionToScroll);
    });
  }

  Future<void> _loadGoalsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sleepGoal = prefs.getInt('sleepGoal') ?? 6;
      stepsGoal = prefs.getInt('stepsGoal') ?? 10000;
      activeMinutesGoal = prefs.getInt('activeMinutesGoal') ?? 30;
    });
  }

  Future<void> _saveGoalsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('sleepGoal', sleepGoal);
    await prefs.setInt('stepsGoal', stepsGoal);
    await prefs.setInt('activeMinutesGoal', activeMinutesGoal);
  }

  void _scrollToSection(String section) {
    GlobalKey? sectionKey;

    if (section == 'Sleep') {
      sectionKey = _sleepKey;
    } else if (section == 'Activity') {
      sectionKey = _activityKey;
    } else if (section == 'Health') {
      sectionKey = _healthKey;
    }

    if (sectionKey != null && sectionKey.currentContext != null) {
      final RenderBox renderBox =
      sectionKey.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero).dy;
      _scrollController.animateTo(
        position,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  // Helper method to update and store data
  void _updateGoal(String goalType, int newValue) {
    setState(() {
      if (goalType == 'sleep') {
        sleepGoal = newValue;
      } else if (goalType == 'steps') {
        stepsGoal = newValue;
      } else if (goalType == 'activeMinutes') {
        activeMinutesGoal = newValue;
      }
    });
    _saveGoalsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goals'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildGoalSection(
                  _sleepKey,
                  'Sleep',
                  [
                    _buildGoalRow('Bedtime', '2:00 AM'),
                    _buildGoalRow('Wake time', '7:30 AM'),
                    _buildGoalRow('Sleep duration', '$sleepGoal hours')
                  ],
                      () => _showGoalDialog('sleep', sleepGoal)),
              _buildGoalSection(
                  _activityKey,
                  'Activity',
                  [
                    _buildGoalRow('Steps Goal', '$stepsGoal steps'),
                    _buildGoalRow('Active Minutes', '$activeMinutesGoal mins')
                  ],
                      () => _showGoalDialog('steps', stepsGoal)),
              _buildGoalSection(
                  _healthKey,
                  'Health',
                  [
                    _buildGoalRow('BMI', '22'),
                    _buildGoalRow('Heart Rate', '70 bpm'),
                  ],
                      () => print('Health Section')),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build each goal row
  Widget _buildGoalRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Helper method to build goal sections
  Widget _buildGoalSection(GlobalKey key, String title, List<Widget> details,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        key: key,
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Column(
              children: details,
            ),
          ],
        ),
      ),
    );
  }

  // Dialog to update goals
  void _showGoalDialog(String goalType, int currentValue) {
    TextEditingController controller =
    TextEditingController(text: currentValue.toString());

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Update $goalType goal'),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter new goal'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  int newValue = int.tryParse(controller.text) ?? currentValue;
                  _updateGoal(goalType, newValue);
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
            ],
          );
        });
  }
}
