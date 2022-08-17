import 'package:apis/bloc/cubit.dart';
import 'package:apis/bloc/states.dart';
import 'package:apis/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Done extends StatelessWidget {
  const Done({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state)
      {

      },
      builder:(context,state)
      {
        var tasks=AppCubit.get(context).donetasks;
        return TasksBuilder(
          tasks: tasks,
        );
      },

    );
  }
}
