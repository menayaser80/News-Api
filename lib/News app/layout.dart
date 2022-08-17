import 'package:apis/bloc/cubit.dart';
import 'package:apis/bloc/states.dart';
import 'package:apis/reusable.dart';
import 'package:apis/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(onPressed: () {
                navigateTo(context, Search(),);
              }, icon: Icon(
                Icons.search,
              ),),
              IconButton(onPressed: () {
                AppCubit.get(context).changeappmode();
              }, icon: Icon(
                Icons.brightness_4_outlined,
              ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.changeindex(index);
            },
            items: cubit.BottomItems,
          ),
        );
      },
    );
  }
}
