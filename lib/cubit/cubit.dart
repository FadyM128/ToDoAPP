import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/cubit/states.dart';


import '../archived_task.dart';
import '../done_task.dart';
import '../new_task.dart';

class AppCubit extends Cubit<AppStates> {

  AppCubit() :super(AppInitialState());

//object
  static AppCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  late Database database;
  late List<Map> newtasks = [];
  late List<Map> donetasks = [];
  late List<Map> archivetasks = [];
  bool isButtonSheetShown = false;
  IconData fabIcon = Icons.edit;


  List<Widget> screens = [
    NewTask(),
    DoneTask(),
    ArchivedTask(),

  ];
  List<String> titles = [
    "New Tasks",
    "Done Tasks",
    "Achrived Tasks",

  ];

  void changeIndex(index) {
    currentindex = index;
    emit(AppChangeBottomNavbarState());
  }

  void createDatabase() {
    //create database
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        //sql statement
        database.execute(
          //id integer
          //title string
          // data string
          // time string
          // status string
            "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT ,time TEXT , status TEXT)"

        ).then((value) {
          print("the table created ");
        }).catchError((error) {
          print('error in creating :${error.toString()}');
        });
        print("database is created");
      },
      onOpen: (database) {
        print("database is opened");
        //get data form database
        getDataFromDatabase(database);
      },

    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,


  }) async
  {
    await database.transaction((txn) {
      txn.rawInsert(
          'INSERT INTO tasks(title , date , time , status) VALUES("$title","$date","$time","new")'
      ).then((value) {
        getDataFromDatabase(database);
        print(" ${value} Inserted task successfully ");
        emit(AppInsertDatabaseState());
      }).catchError((error) => print('error in insert ${error.toString()}'));
      return Future(() => null);
    });
  }

  void getDataFromDatabase(database) {
    newtasks.clear();
    donetasks.clear();
    archivetasks.clear();
    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks')
        .then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newtasks.add(element);
        else if (element['status'] == 'done')
          donetasks.add(element);
        else if (element['status'] == 'archive')
          archivetasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,


  }) {
    isButtonSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void updateToDatabase({
    required String status,
    required int id,


  }) async

  {
    database.rawUpdate(
        'UPDATE tasks SET status =? WHERE id=?',
        ['$status', id]


    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteFromDatabase({

    required int id,


  }) async

  {
    database.rawDelete(

        'DELETE FROM tasks WHERE id = ?', [id]

    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
