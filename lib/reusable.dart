import 'package:apis/bloc/cubit.dart';
import 'package:apis/modules/webview.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(article,context)=> InkWell(
  onTap: (){
navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image:  DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            width: 120,
            height: 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style:Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text('${article['publishedAt']}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),],
            ),
          ),
        ),
      ],
    ),
  ),
);
Widget myDivider()=>Padding(
  padding: EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],

  ),
);
Widget articlebuilder(list,context,{issearch=false})=>ConditionalBuilder(
  condition:list.length>0,
  builder:(context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder:(context,index)=>buildArticleItem(list[index],context),
    separatorBuilder:(context,index)=>myDivider(),
    itemCount:10,
  ) ,
  fallback:(context)=>issearch?Container():Center(child: CircularProgressIndicator()) ,
);
Widget TasksBuilder({
  required List<Map>tasks,
})=>ConditionalBuilder(
  condition: tasks.length>0,
  builder:(context)=> ListView.separated(itemBuilder:(context,index)=>builditem(
      tasks[index],context), separatorBuilder: (context,index)=>Padding(
    padding: EdgeInsetsDirectional.only(
      start: 20.0,
    ),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  ), itemCount: tasks.length),
  fallback:(context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks yet,please add some tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ) ,
);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Widget builditem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  child:Padding(

    padding: const EdgeInsets.all(20.0),

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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model['title']}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),),

              Text('${model['date']}',

                style: TextStyle(

                  color: Colors.grey,

                ),),



            ],

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        IconButton(onPressed: (){

          AppCubit.get(context).UpdateData(status: 'done', id: model['id'],);

        },

          icon: Icon(

            Icons.check_box,

            color: Colors.green,

          ),

        ),

        IconButton(onPressed: (){

          AppCubit.get(context).UpdateData(status: 'archive', id: model['id'],);



        },

          icon: Icon(

            Icons.archive,

            color: Colors.blueGrey ,

          ),

        ),



      ],

    ),

  ),
  onDismissed:(direction)
  {
    AppCubit.get(context).DeleteData(id: model['id']);
  } ,
);
Widget defaultformfield({
  required TextEditingController controller,
  required TextInputType type,
  Function(String x)?onchange,
  required String? Function(String?val)?validator,
  required String label,
  required IconData prefix,
})=> TextFormField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(
        prefix,
      ),
      labelText: label,
      border: OutlineInputBorder(),
    ),
    validator: validator,

    keyboardType:type,
    onChanged:onchange
);
void navigateTo(context,Widget)=>Navigator.push(context, MaterialPageRoute(
  builder:(context)=>Widget,
));
