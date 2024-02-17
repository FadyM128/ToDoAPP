
import 'package:flutter/material.dart';

import '../cubit/cubit.dart';

Widget defaultButton({
   double width=double.infinity,
   Color background=Colors.blue,
  double x =10.0,

  bool isUpperCase=true,
    required Function() function,
  required String text,

})=>  Container(

  width:width,
  decoration:BoxDecoration(
  borderRadius: BorderRadius.circular(x,


  ),
    color: background,
  ),
  child: MaterialButton(
    onPressed:  function,
    child: Text(
      isUpperCase? text.toUpperCase():text,

      style: TextStyle(
        color: Colors.white,

      ),

    ),
  ),
);


Widget defaultFormField({
  bool isClickable=true,

required TextEditingController controller,
required TextInputType type,
required String? Function(String?) validator,
  bool ispassword= false,
  bool suffix=false,
  void Function()?  onTap ,
  required String text,
  required IconData ic,
  IconData ic_suffix =Icons.remove_red_eye,
  required Function() Suffix_funcation,
  Function(String)? onchange,



})=>   TextFormField(
  //vaildation
  validator: validator,
  obscureText: ispassword,
  controller: controller,
  keyboardType: type,
onChanged: onchange,
  decoration:InputDecoration(
    border: OutlineInputBorder(),

    labelText: '${text}',
    prefixIcon: Icon(ic),
    suffixIcon: suffix ? IconButton(
      onPressed: Suffix_funcation ,
         icon: Icon(ic_suffix)) :null,

  ) ,
  onFieldSubmitted:(value){
    print(value);
  } ,
  enabled: isClickable,
  onTap: onTap,

);

Widget buildTaskItem(
Map model,
    context,

    )=>Dismissible(
  key:Key(model['id'].toString()) ,
      child: Padding(
  padding: const EdgeInsets.all(15.0),
  child: Row(

      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
              '${model['time']}'

          ),



        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,

                ),

              ),
              Text(
                '${model['date']} ',
                style: TextStyle(

                    color: Colors.grey
                ),

              ),


            ],


          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        IconButton(
            onPressed: (){

              AppCubit.get(context).updateToDatabase(
                  status: 'done',
                  id: model['id']);

            },
            icon: Icon(
              Icons.check,
              color: Colors.green,
            ),
        ),


        IconButton(
          onPressed: (){

            AppCubit.get(context).updateToDatabase(
                status: 'archive',
                id: model['id']);

          },
          icon: Icon(
            Icons.archive,
            color: Colors.black45,
          ),
        ),
      ],
  ),
),
  onDismissed: (direction){

    AppCubit.get(context).deleteFromDatabase(id: model['id']);

  },
    );

Widget myDivider()=>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],

      ),
    );




void navigateTo(context,widget)=> Navigator.push(context,
  MaterialPageRoute(builder:
      (context)=>widget,

  ),

);