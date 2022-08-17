import 'package:apis/News%20app/layout.dart';
import 'package:apis/bloc/cubit.dart';
import 'package:apis/bloc/states.dart';
import 'package:apis/cashe%20helper.dart';
import 'package:apis/dio%20helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'bloc/bloc observer.dart';
void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
        () async {
          // byt2kd en kol 7aga f el method 5lst w b3den yft7 el application
          DioHelper.init();
         await CachHelper.init();
          bool? isdark = CachHelper.getBoolean(key: 'isdark');
          runApp(MyApp(isdark));
    },
    blocObserver: MyBlocObserver(),
  );
}
class MyApp extends StatelessWidget {
  final bool? isdark;
  MyApp(this.isdark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>NewsCubit()..getbusiness()..getsports()..getscience()),
        BlocProvider(create:  (BuildContext context)=>AppCubit()..changeappmode(fromshared:isdark,
    ),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            theme: ThemeData(
              primarySwatch:Colors.deepOrange,
              scaffoldBackgroundColor:Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness:Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor:Colors.grey,
                elevation: 20.0,
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch:Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor:HexColor('333739'),
                  statusBarIconBrightness:Brightness.light,
                ),
                backgroundColor:HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor:Colors.grey,
                elevation: 20.0,
                backgroundColor: HexColor('333739'),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode:AppCubit.get(context).isdark?ThemeMode.dark:ThemeMode.light,
            home:Directionality(
                textDirection: TextDirection.ltr,
                child: Layout()),
          );
        },
      ),
    );
  }
}

