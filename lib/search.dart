import 'package:apis/bloc/cubit.dart';
import 'package:apis/bloc/states.dart';
import 'package:apis/reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatelessWidget {
var Searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:   defaultformfield(
                  controller:Searchcontroller,
                  type:TextInputType.text,
                  onchange: (value){
                    NewsCubit.get(context).getsearch(value);
                  },
                  validator:(value){
                    if(value!.isEmpty)
                    {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: articlebuilder(list, context,issearch: true,
              ),
              ),
            ],
          ),
        );
      },
    );
  }
}
