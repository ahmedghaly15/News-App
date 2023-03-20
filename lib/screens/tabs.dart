import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/search_screen.dart';
import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (BuildContext context, NewsAppStates state) {},
      builder: (BuildContext context, NewsAppStates state) {
        NewsAppCubit cubit = NewsAppCubit.getObject(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.screensTitles[cubit.currentIndex]),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  //============= Navigating To Search Screen =============
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (int index) => cubit.changeBottomNavBarItem(index),
          ),
        );
      },
    );
  }
}
