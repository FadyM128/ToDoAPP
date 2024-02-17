
import 'dart:core';
import 'dart:core';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'component/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

//import '../shared/component/constants.dart';


//create database
//create tables
//open database
//insert to database
//get from database
//updata in database
//delete from database


class Home_layout extends StatelessWidget  {


  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();


  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //create object from cubit
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDatabaseState) Navigator.pop(context);

        },
        builder: (BuildContext context,AppStates state){
          AppCubit cubit =AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            floatingActionButton: FloatingActionButton(

              onPressed: ()
              {
                if (cubit.isButtonSheetShown){

                  if(formKey.currentState!.validate()) {
                    cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);
                  //   insertToDatabase(
                  //     title: titleController.text,
                  //     date: dateController.text,
                  //     time: timeController.text,
                  //
                  //   ).then((value) {
                  //     getDataFromDatabase(database).then((value){
                  //       //   setState(()
                  //       //   {
                  //       //     tasks= value;
                  //       //     print(tasks);
                  //       //
                  //       //     fabIcon = Icons.edit;
                  //       //     isButtonSheetShown = false;
                  //       //   });

                  //
                  //
                  //     });
                  //
                  //
                  //
                  //
                  //   });
                  //
                  //
                  //
                   }

                }
                // try {
                //   var name = await getName();
                //   print(name);
                //   print('osama');
                //  // throw('some error !!!!!!!!!!');
                // }catch(error){
                //
                //   print('error : ${error.toString()}');
                // }
                //

                // must wait the future funcation for return the data

                // getName().then(
                //
                //         (value) => {
                //         print(value),
                //         print("osama"),
                //        throw ('i make the error '),
                //
                //         }).catchError((error){
                //
                //           print(error.toString());
                // });
                //
                // button sheet
                else {
                  scaffoldKey.currentState?.showBottomSheet((context) =>
                      Container(

                        color:Colors.white,
                        padding: EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  validator: (String? value)
                                  {
                                    if (value!.isEmpty){
                                      return"Title must not be empty ";

                                    }
                                    return null;


                                  },


                                  ic: Icons.title,
                                  text: 'Task Title',
                                  Suffix_funcation: (){}

                              ),
                              SizedBox(
                                height: 15
                                ,
                              )
                              ,

                              defaultFormField(
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  validator: (String? value)
                                  {
                                    if (value!.isEmpty){
                                      return"Time must not be empty ";

                                    }
                                    return null;


                                  },


                                  ic: Icons.alarm,
                                  text: 'Task Time',
                                  Suffix_funcation: (){},
                                  onTap: ()
                                  {
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now()
                                    ).then((value)
                                    {

                                      timeController.text=value!.format(context).toString();

                                    });

                                  }

                              ),
                              SizedBox(
                                height: 15
                                ,
                              )
                              ,



                              defaultFormField(

                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  validator: (String? value)
                                  {
                                    if (value!.isEmpty){
                                      return"Date must not be empty ";

                                    }
                                    return null;


                                  },


                                  ic: Icons.calendar_month,
                                  text: 'Task Date',
                                  Suffix_funcation: (){},
                                  onTap: ()
                                  {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2030),
                                    ).then((value) {

                                      dateController.text=DateFormat.yMMMd().format(value!);


                                    });
                                  }

                              ),



                            ],
                          ),
                        ),
                      ),
                    elevation: 20.0,
                  ).closed.then((value) {

                    cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                  });
                 
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }

              },
              child:
              Icon(
                  cubit.fabIcon

              ),


            ) ,
            appBar: AppBar(
              title: Text(

                cubit.titles[cubit.currentindex],
              ),
            ),
            body:cubit.screens[cubit.currentindex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentindex,
              onTap: (index)
              {

                // setState((){
                //
                //   currentindex=index;
                // });
               cubit.changeIndex(index);



              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon (Icons.menu),
                  label: 'Tasks',

                ),
                BottomNavigationBarItem(
                  icon: Icon (Icons.check),
                  label: 'Done',

                ),
                BottomNavigationBarItem(
                  icon: Icon (Icons.archive_outlined),
                  label: 'Archived',

                ),


              ],

            ),



          );
        },
      ),
    );
  }
//thread method
  Future  < String> getName ()  async
  {

    return "Ahmed ali" ;
  }

}



