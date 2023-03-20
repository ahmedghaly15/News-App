import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '/screens/web_view_screen.dart';

//==================== Function For Building The Article Items (News) ====================
Widget buildArticleItem({
  required BuildContext context,
  required article,
}) {
  // For A Responsive App
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return GestureDetector(
    onTap: () {
      //============ Navigating To Web Screen Of this News ============
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(url: article['url']),
        ),
      );
    },
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.015,
      ),
      child: Card(
        color: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.025),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: screenHeight * 0.2,
              width: screenWidth * 0.35,
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03,
                vertical: screenHeight * 0.015,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
                image: DecorationImage(
                  image: NetworkImage(
                    //========= An Image Of This News =========
                    "${article['urlToImage']}",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: screenHeight * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.03),
                        child: Text(
                          //========= Title Of This News =========
                          article['title'],
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Text(
                      //========= Date Of Publishing This News =========
                      article['publishedAt'],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

//==================== Function For Building The Article ====================
Widget articleBuilder({
  required List<dynamic> list,
  isSearch = false,
}) {
  return ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(
        context: context,
        article: list[index],
      ),
      itemCount: list.length,
    ),
    fallback: (context) => isSearch
        ? Container()
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          ),
  );
}

//======================== Function For Building A Text Form =============================
Widget buildTextFormField({
  required BuildContext context,
  String? hint,
  bool? enableSuggestions,
  Widget? icon,
  TextEditingController? controller,
  void Function(String)? onChanged,
  TextInputType? keyboardType,
}) {
  // For Making App Responsive
  double screenWidth = MediaQuery.of(context).size.width;
  return TextFormField(
    enableSuggestions: enableSuggestions!,
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: icon,
      prefixIconColor: Colors.white,
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 1,
        color: Colors.grey,
      ),
      contentPadding: EdgeInsets.only(left: screenWidth * 0.03),
      border: const OutlineInputBorder(),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          borderSide: const BorderSide(color: Colors.white)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          )),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        borderSide: const BorderSide(color: Colors.white),
      ),
    ),
    style: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      letterSpacing: 1,
      fontWeight: FontWeight.w400,
    ),
    keyboardType: keyboardType,
    onChanged: onChanged,
  );
}
