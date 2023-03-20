import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/network/remote/dio_helper.dart';
import '/screens/tabs.dart';
import '/shared/bloc_observer.dart';
import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';

void main() {
  //===================== Observing My Bloc =====================
  Bloc.observer = MyBlocObserver();

  //===================== Initializing My API =====================
  DioHelper.init();

  //===================== Running App =====================
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsAppCubit()..getBusinessData(),
      child: BlocConsumer<NewsAppCubit, NewsAppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          //======= App Is In Dark Theme =========
          themeMode: ThemeMode.dark,
          //========= Dark Theme Settings =========
          darkTheme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF121212),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF121212),
              elevation: 0.0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Color(0xFF121212),
                statusBarIconBrightness: Brightness.light,
              ),
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Colors.white,
                size: 25,
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.shifting,
              backgroundColor: Colors.red,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              selectedLabelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              elevation: 20.0,
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                wordSpacing: 0.3,
              ),
              bodySmall: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          //================== First Screen Of The App ==================
          home: const Tabs(),
        ),
      ),
    );
  }
}
