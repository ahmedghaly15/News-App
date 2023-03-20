import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/network/remote/dio_helper.dart';
import '/screens/business_screen.dart';
import '/screens/science_screen.dart';
import '/screens/sports_screen.dart';
import '/shared/cubit/states.dart';

class NewsAppCubit extends Cubit<NewsAppStates> {
  NewsAppCubit() : super(NewsInitialState());

  static NewsAppCubit getObject(context) => BlocProvider.of(context);

  //====== Index Of Current Bottom Nav Item ======
  int currentIndex = 0;

  //====== Search Text Field Controller ======
  TextEditingController searchController = TextEditingController();

  //====== Items Of The Bottom Nav Bar ======
  List<BottomNavigationBarItem> bottomItems = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
      backgroundColor: Colors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
      backgroundColor: Colors.red,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
      backgroundColor: Colors.red,
    ),
  ];

  //====== List Of The Screens Of Bottom Nav Bar Items ======
  List<Widget> screens = const <Widget>[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<String> screensTitles = <String>[
    "Business News",
    "Sports News",
    "Science New",
  ];

  //============= For Navigating Among Bottom Nav Bar Items =============
  void changeBottomNavBarItem(int index) {
    currentIndex = index;
    if (currentIndex == 1) getSportsData();
    if (currentIndex == 2) getScienceData();
    emit(NewsBottomNavState());
  }

//============= For Getting The Business Screen News =============
  List<dynamic> business = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      queries: {
        'country': 'us',
        'category': 'business',
        'apiKey': '389f115f079e4661b5fda7163aaa87d6',
      },
    ).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print("Error Occurred: ${error.toString()}");
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

//============= For Getting The Sports Screen News =============
  List<dynamic> sports = [];

  void getSportsData() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        queries: {
          'country': 'us',
          'category': 'sports',
          'apiKey': '389f115f079e4661b5fda7163aaa87d6',
        },
      ).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print("Error Occurred: ${error.toString()}");
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

//============= For Getting The Science Screen News =============
  List<dynamic> science = [];

  void getScienceData() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        queries: {
          'country': 'us',
          'category': 'science',
          'apiKey': '389f115f079e4661b5fda7163aaa87d6',
        },
      ).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print("Error Occurred: ${error.toString()}");
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

//============= For Getting The Search Screen News =============
  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      queries: {
        'q': value,
        'apiKey': '389f115f079e4661b5fda7163aaa87d6',
      },
    ).then((value) {
      search = value.data['articles'];

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print("Error Occurred: ${error.toString()}");
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
