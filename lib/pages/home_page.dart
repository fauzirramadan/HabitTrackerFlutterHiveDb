import 'package:flutter/material.dart';
import 'package:habittrackertute/components/habit_tile.dart';
import 'package:habittrackertute/components/month_summary.dart';
import 'package:habittrackertute/components/my_button.dart';
import 'package:habittrackertute/components/my_alert_box.dart';
import 'package:habittrackertute/data/habit_database.dart';
import 'package:habittrackertute/utils/colors.dart';
import 'package:habittrackertute/utils/notif_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../components/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> keyForm = GlobalKey();
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");

  @override
  void initState() {
    // if there is no current habit list, then it is the 1st time ever opening the app
    // then create default data
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    }

    // there already exists data, this is not the first time
    else {
      db.loadData();
    }

    // update the database
    db.updateDatabase();

    super.initState();
  }

  // checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
    db.updateDatabase();
  }

  // create a new habit
  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    // show alert dialog for user to enter the new habit details
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: 'Enter habit name..',
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
          keyForm: keyForm,
        );
      },
    );
  }

  // save new habit
  void saveNewHabit() {
    if (keyForm.currentState!.validate()) {
      // add new habit to todays habit list
      setState(() {
        db.todaysHabitList.add([_newHabitNameController.text, false]);
      });

      // clear textfield
      _newHabitNameController.clear();
      NotifUtils.showSnackBar(context,
          isSuccess: true,
          color: semanticGreen,
          message: "Jangan lupa dikerjakan ya");
      // pop dialog box
      Navigator.of(context).pop();
      db.updateDatabase();
    }
  }

  // cancel new habit
  void cancelDialogBox() {
    // clear textfield
    _newHabitNameController.clear();

    // pop dialog box
    Navigator.of(context).pop();
  }

  // open habit settings to edit
  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: db.todaysHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
          keyForm: keyForm,
        );
      },
    );
  }

  // save existing habit with a new name
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
    NotifUtils.showSnackBar(context,
        isSuccess: true, color: semanticGreen, message: "Berhasil dihapus");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: CustomScrollView(slivers: [
        const MySliverAppBar(),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              // monthly summary heat map
              MonthlySummary(
                datasets: db.heatMapDataSet,
                startDate: _myBox.get("START_DATE"),
              ),

              // list of habits
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "My Habits",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          MyButton(
                            onTap: createNewHabit,
                          ),
                        ],
                      ),
                    ),
                    db.todaysHabitList.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 100),
                            child: Text(
                              "EMPTY LIKE YOUR HEART : )",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: db.todaysHabitList.length,
                            itemBuilder: (context, index) {
                              return HabitTile(
                                habitName: db.todaysHabitList[index][0],
                                habitCompleted: db.todaysHabitList[index][1],
                                onChanged: (value) =>
                                    checkBoxTapped(value, index),
                                settingsTapped: (context) =>
                                    openHabitSettings(index),
                                deleteTapped: (context) => deleteHabit(index),
                              );
                            },
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
