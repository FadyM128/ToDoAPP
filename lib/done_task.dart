import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class DoneTask extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(

      listener:(context,state){} ,
      builder: (context,state) {
        var tasks = AppCubit
            .get(context)
            .donetasks;

        return tasks.length==0? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                  Icons.check,
                size: 100,
                color: Colors.green,
              ),
              Text(
                  "Done Tasks",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black45,


                ),
              ),
            ],
          ),
        ):ListView.separated(
            itemBuilder: (context, index) => buildTaskItem(tasks[index],context),

            separatorBuilder: (context, index) =>
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],

                  ),
                ),
            itemCount: tasks.length);
      },

    );
  }
}
