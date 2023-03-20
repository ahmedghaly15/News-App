import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared/cubit/cubit.dart';
import '/shared/cubit/states.dart';
import '/widgets/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // For Making A Responsive App
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        List<dynamic> list = NewsAppCubit.getObject(context).search;

        return GestureDetector(
          //=========== Closing The Keyboard When The Screen is Tapped ===========
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  //========== Moving Back ===========
                  Navigator.pop(context);
                },
              ),
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.035,
                    vertical: screenHeight * 0.02,
                  ),

                  //=========== Search Text Field ===========
                  child: buildTextFormField(
                    enableSuggestions: true,
                    context: context,
                    onChanged: (String value) {
                      NewsAppCubit.getObject(context).getSearch(value);
                    },
                    controller:
                        NewsAppCubit.getObject(context).searchController,
                    keyboardType: TextInputType.text,
                    hint: "Search...",
                    icon: const Icon(Icons.search),
                  ),
                ),
                Expanded(
                  child: articleBuilder(list: list, isSearch: true),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
