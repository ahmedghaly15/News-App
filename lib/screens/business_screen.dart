import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';
import '/widgets/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> list = NewsAppCubit.getObject(context).business;
        return articleBuilder(list: list);
      },
    );
  }
}
