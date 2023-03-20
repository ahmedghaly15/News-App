import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';
import '/widgets/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> list = NewsAppCubit.getObject(context).sports;
        return articleBuilder(list: list);
      },
    );
  }
}
