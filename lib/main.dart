import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:sdg/src/screens/splash_screen/Splashscreen.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: const Scaffold(
        body: Center(child: MyHomePage()),
        //body: Center(child: MyDropdown()),
      ),
    );
  }
}
















// import 'dart:convert';
//
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:sdg/src/constants/text_strings.dart';
//
// extension StringCasingExtension on String {
//   String toCapitalized() =>
//       length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
//
//   String toTitleCase() => replaceAll(RegExp(' +'), ' ')
//       .split(' ')
//       .map((str) => str.toCapitalized())
//       .join(' ');
// }
//
// void main() {
//   runApp(const MaterialApp(home: HomeScreen(), title: 'Flutter Example'));
// }
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   final List<String> _kOptionsItems = <String>[];
//   String? _iteminputString;
//
//   var txtAlbumSuggest = TextEditingController();
//
//   final GlobalKey<AutoCompleteTextFieldState<String>>
//       _AutoCompleteTextFieldStatekey =
//       GlobalKey<AutoCompleteTextFieldState<String>>();
//
//
//   ///////////////////////////////////////////////////////////////
//
//   List<dynamic> _http_kOptionsItems = [];
//
//   Future<List> getData_kOptionsItems() async {
//     var url = "http://$ipAddress/sdg/kcounts/getdata.php";
//     final response = await http.post(Uri.parse(url), body: {
//       'transect': 'T1',
//       'beachID': 'Kijangwan Beach',
//     });
//
//     var responsedata = jsonDecode(response.body)[0]['Items'];
//     //print(responsedata);
//
//     return json.decode(response.body);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) => _loadItems(context));
//   }
//
//   void _loadItems(BuildContext context) async {
//     _http_kOptionsItems = await getData_kOptionsItems();
//
//     setState(() {
//       for (int i = 0; i < _http_kOptionsItems.length; i++) {
//         _kOptionsItems.add(_http_kOptionsItems[i]['Items']);
//       }
//
//     });
//
//     print(_kOptionsItems.toSet());
//   }
//
//
//   ////////////////////////////////////////////////////////////////////////////
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//             child: Container(
//               width: double.infinity,
//               height: 50,
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: AutoCompleteTextField(
//                 controller: txtAlbumSuggest,
//                 suggestions: _kOptionsItems,
//                 clearOnSubmit: false,
//                 style: const TextStyle(color: Colors.black, fontSize: 15),
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.5))),
//                 itemFilter: (item, query) {
//                   return item.toLowerCase().startsWith(query.toLowerCase());
//                 },
//                 itemSorter: (a, b) {
//                   return a.compareTo(b);
//                 },
//                 itemSubmitted: (item) {
//                   txtAlbumSuggest.text = item;
//                   print('$item  ${txtAlbumSuggest.text}');
//                 },
//                 itemBuilder: (context, item) {
//                   return Container(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Row(
//                       children: <Widget>[
//                         Text(
//                           item,
//                           style: const TextStyle(color: Colors.black),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//
//                 key: _AutoCompleteTextFieldStatekey,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Autocomplete<String>(
//             optionsBuilder:
//                 (TextEditingValue textEditingValue) {
//               if (textEditingValue.text == '') {
//                 return const Iterable<String>.empty();
//               }
//
//               setState(() {
//                 _iteminputString = textEditingValue.text;
//               });
//
//               return _kOptionsItems.toSet().where((String option) {
//                 return option.toTitleCase().contains(
//                     textEditingValue.text.toTitleCase());
//               });
//             },
//             fieldViewBuilder: ((context,
//                 textEditingController,
//                 focusNode,
//                 onFieldSubmitted) {
//               return TextFormField(
//                 controller: textEditingController,
//                 focusNode: focusNode,
//                 onEditingComplete: onFieldSubmitted,
//                 decoration: InputDecoration(
//                   hintText: 'Item Name',
//                   prefixIcon: const Icon(
//                     Icons.pending_actions,
//                   ),
//                   suffixIcon: IconButton(
//                     onPressed: () {
//                       textEditingController.clear();
//                     },
//                     icon: const Icon(
//                       Icons.cancel,
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }












