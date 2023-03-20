import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';
import '/widgets/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsAppCubit.getObject(context).science;
        return articleBuilder(list: list);
      },
    );
  }
}
