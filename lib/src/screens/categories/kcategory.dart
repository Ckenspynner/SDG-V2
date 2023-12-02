import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sdg/src/constants/color.dart';
import 'package:sdg/src/models/category_model.dart';
import 'package:sdg/src/screens/branding/brandItems.dart';
import 'package:sdg/src/screens/categoryitems/categoryItems.dart';
import 'package:sdg/src/screens/dataview/DataView.dart';
import 'package:http/http.dart' as http;

import '../../constants/text_strings.dart';
import '../dataview/DataViewBrand.dart';

class KCategory extends StatefulWidget {
  final String selectedTransectZoneTag;
  final String selectedTransectTag;
  final String transectID;
  final String countyID;
  final String beachID;
  final String startDryGPS;
  final String centerGPS;
  final String endWetGPS;
  final String distanceInMeters;

  const KCategory(
      {super.key,
      required this.selectedTransectZoneTag,
      required this.selectedTransectTag,
      required this.transectID,
      required this.countyID,
      required this.beachID,
      required this.startDryGPS,
      required this.centerGPS,
      required this.endWetGPS,
      required this.distanceInMeters});

  @override
  State<StatefulWidget> createState() {
    return _KCategoryState();
  }
}

class _KCategoryState extends State<KCategory> {
  int tapped_index = 0;
  final category = CategoryModel.category;

  List<dynamic> _http_kOptionsCategory = [];
  final List<String> _kOptionsCategory = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadItems(context));
  }

  //Get autocomplete list filter data
  Future<List> getData_kOptionsCategory() async {
    final response =
        await http.get(Uri.parse("http://$ipAddress/sdg/counts/getdata.php"));
    return json.decode(response.body);
  }

  //Load Item autocomplete textfield
  void _loadItems(BuildContext context) async {
    _http_kOptionsCategory = await getData_kOptionsCategory();
    //print(_http_kOptionsCategory.toSet());

    // final double wettotal = _http_kOptionsCategory.toSet().fold(0, (sum, item) => sum + item.Counts);
    // final double drytotal = _http_kOptionsCategory.toSet().fold(0, (sum, item) => sum + item.Weight);
    //
    // print('$wettotal $drytotal');

    setState(() {
      for (int i = 0; i < _http_kOptionsCategory.length; i++) {
        _kOptionsCategory.add(_http_kOptionsCategory[i]['Category'].trim());
      }
    });

    //print(_kOptionsCategory.toSet());
  }

  var ScreenSize;

  @override
  Widget build(BuildContext context) {
    ScreenSize = MediaQuery.of(context).size.width;
     print(widget.distanceInMeters);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.selectedTransectZoneTag} Zone'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: ScreenSize >= 800
              ? EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 8,
                  bottom: MediaQuery.of(context).size.height / 8,
                  left: MediaQuery.of(context).size.width / 4,
                  right: MediaQuery.of(context).size.width / 4)
              : EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 7,
                  bottom: MediaQuery.of(context).size.height / 7,
                  left: 16,
                  right: 16),
          itemCount: category.length,
          itemBuilder: (BuildContext context, int index) {
            return buildCard(index);
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0 / 1.2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
          ),
        ),
      ),
    );
  }

  Widget buildCard(int index) {
    bool tapped = index == tapped_index;
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CategoryItems(
                    selectedCategoryTag: category[index].title,
                    selectedCategoryTransectTag: widget.selectedTransectTag,
                    transectID: widget.transectID,
                    countyID: widget.countyID,
                    beachID: widget.beachID,
                    startDryGPS: widget.startDryGPS,
                    centerGPS: widget.centerGPS,
                    endWetGPS: widget.endWetGPS,
                    zone: widget.selectedTransectZoneTag,
                    distanceInMeters: widget.distanceInMeters,
                  )));
          setState(() {
            tapped_index = index;
          });
          print(widget.beachID);
        }
        if (index == 1) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => //const CategoryItems()
                  BrandItems(
                      selectedBrandTag: 'Branding Page',
                      selectedBrandTransectTag: '',
                      countyID: widget.countyID,
                      beachID: widget.beachID,
                      zone: widget.selectedTransectZoneTag,
                      transect: widget.transectID)));
          setState(() {
            tapped_index = index;
          });
        }
        if (index == 2) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DataViewsCounts(
                    beachID: widget.beachID,
                    transect: widget.transectID,
                  )));
          // print(widget.beachID);
          // print(widget.transectID);
          setState(() {
            tapped_index = index;
          });
          //print('Index $index long pressed');
        }
        if (index == 3) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => DataViewsBrand(
                beachID: widget.beachID,
                transect: widget.transectID,
              ),
            ),
          );
          setState(() {
            tapped_index = index;
          });
        }
      },
      //   onLongPress: () {
      // if(index==2){
      //     Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => DataViewsCounts(
      //               beachID: widget.beachID,
      //               transect: widget.transectID,
      //             )));
      //     //print('Index $index long pressed');
      //   }},
      //   onDoubleTap: () {
      // if(index==1) {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => //const CategoryItems()
      //       BrandItems(
      //           selectedBrandTag: 'Branding Page',
      //           selectedBrandTransectTag: '',
      //           countyID: widget.countyID,
      //           beachID: widget.beachID,
      //           zone: widget.selectedTransectZoneTag,
      //           transect: widget.transectID)));
      // }},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: tapped ? mainColor : Colors.white,
            style: BorderStyle.solid,
            width: 5.0,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: AlignmentDirectional.center,
              // child: Image.network(
              //   category[index].pictures,
              //   width: MediaQuery.of(context).size.height / 5,
              // ),
              child: Image.asset(
                category[index].pictures,
                width: MediaQuery.of(context).size.width / 5,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                height: ScreenSize >= 800
                    ? MediaQuery.of(context).size.width / 14
                    : MediaQuery.of(context).size.width / 8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0)),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      category[index].title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
