import 'dart:convert';
import 'dart:core';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:sdg/main.dart';
import 'package:sdg/src/constants/text_strings.dart';
import 'package:http/http.dart' as http;

class CategoryItems extends StatefulWidget {
  final String selectedCategoryTag;
  final String selectedCategoryTransectTag;
  final String transectID;
  final String countyID;
  final String beachID;
  final String startDryGPS;
  final String centerGPS;
  final String endWetGPS;
  final String zone;
  final double distanceInMeters;

  const CategoryItems({
    Key? key,
    required this.selectedCategoryTag,
    required this.selectedCategoryTransectTag,
    required this.transectID,
    required this.countyID,
    required this.beachID,
    required this.startDryGPS,
    required this.centerGPS,
    required this.endWetGPS,
    required this.zone,
    required this.distanceInMeters,
  }) : super(key: key);

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  var controllerWeight = TextEditingController();
  var controllerCount = TextEditingController();

  var combinedCheckboxValueSelected = '';
  var splitagItem, splitagValues, splitagZone;

  List multipleSelected = [];
  List checkListItems = [];

  String? _itemName, _save_button_status = 'Save';

  List<dynamic> _http_kOptionsItems = [];
  final _dropdownFormKey = GlobalKey<FormState>();
  String selectedCategory = "Select Category";

  //Dropdown parameters definition
  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Select Category", child: Text("Select Category")),
      const DropdownMenuItem(
          value: "Building & Construction",
          child: Text("Building & Construction")),
      const DropdownMenuItem(
          value: "Paper & Cardboard", child: Text("Paper & Cardboard")),
      const DropdownMenuItem(
          value: "Marine & Fishing", child: Text("Marine & Fishing")),
      const DropdownMenuItem(
          value: "Processed Wood", child: Text("Processed Wood")),
      const DropdownMenuItem(
          value: "Clothing - Covid", child: Text("Clothing - Covid")),
      const DropdownMenuItem(value: "E - Waste", child: Text("E - Waste")),
      const DropdownMenuItem(value: "Plastic", child: Text("Plastic")),
      const DropdownMenuItem(value: "Rubber", child: Text("Rubber")),
      const DropdownMenuItem(value: "Hygiene", child: Text("Hygiene")),
      const DropdownMenuItem(value: "Metal", child: Text("Metal")),
      const DropdownMenuItem(value: "Glass", child: Text("Glass")),
      const DropdownMenuItem(value: "Foam", child: Text("Foam")),
      const DropdownMenuItem(value: "Others", child: Text("Others")),
    ];
    return menuItems;
  }

  final List<String> _kOptionsItems = <String>[
    'Aluminum Foil',
    'Asbestos',
    'Baloon',
    'Basin',
    'Bathing Rug',
    'Battery',
    'Battery Lid',
    'Beverage Bottle',
    'Beverage Can',
    'Blister Packs',
    'Boat Fibre',
    'Books',
    'Buoy',
    'Burnt Plastic',
    'Button',
    'Caps/Lids/Rings',
    'Carrier Bag',
    'Carton',
    'Cello Tape',
    'Ceramic',
    'Cigarette Butt',
    'Cigarette Lighter',
    'Cigarette Packet',
    'Cloth Mask',
    'Clothes',
    'Comb',
    'Condom',
    'Cosmetic Container',
    'Cotton Buds',
    'Credit Card',
    'Cups And Plates',
    'Diaper',
    'Electric Cable',
    'Fishing Line',
    'Fishing Net',
    'Fishing Rope',
    'Flipflop',
    'Flipflop Fragments',
    'Foam',
    'Food Container',
    'Food Wrapper',
    'Glass Bottle',
    'Glass Fragment',
    'Handle Brush',
    'Hard Plastic',
    'Hdpe Container',
    'Household Wrappers',
    'Ice Cream Stick',
    'Jerican',
    'Kinangop Milk',
    'Leather Bag',
    'Lighter',
    'Manilaa Rope',
    'Mattress',
    'Medicine Blister Packs',
    'Medicine Blister Packs Bottle',
    'Medicine Blister Packs Sachet',
    'Metal',
    'Metal Can',
    'Metal Cap',
    'Metal Fragment',
    'Metal Sheet',
    'Metal Wire',
    'Mosquito Net',
    'Nails',
    'Net',
    'Newspaper',
    'Oil Container',
    'Paper',
    'Paper Bag',
    'Peg Fragments',
    'Pens',
    'Pet Bottle',
    'Pet Fragment',
    'Phone Cable',
    'Phone Cover',
    'Plastic Caps',
    'Plastic Cups',
    'Plastic Fragments',
    'Plastic Rope',
    'Plastic Torch',
    'Plate',
    'Poker Cards',
    'Porcelain',
    'Processed Wood',
    'Pvc Canvas',
    'Pvc Carpet',
    'Pvc Pipe',
    'Razor Blade',
    'Receipt',
    'Rope',
    'Rubber Fragment',
    'Sack',
    'Sandpaper',
    'Sanitary Towel',
    'Sanitary Towel Wrapper',
    'Scratch Card',
    'Seal',
    'Sheeting',
  ];

  bool changeColor = false;

  String combinedCheckboxValue = '', itemName = '';
  double itemWeight = 0.0;
  int itemCounts = 0;

  final ScrollController _controllerCheckboxTile = ScrollController();

// This is what you're looking for!
  void _scrollDown() {
    _controllerCheckboxTile.animateTo(
      _controllerCheckboxTile.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   int x = -1;
  //   for (int i = 0; i < checkListItems1.length; i++) {
  //     if (checkListItems1[i]["Category"] == widget.selectedCategoryTag) {
  //       x++;
  //
  //       checkListItems.insert(x, {
  //         "value": false,
  //         "title": checkListItems1[i]["title"],
  //         "Category": widget.selectedCategoryTag,
  //         "count": "0",
  //         "weight": "0",
  //       });
  //     } else {
  //       continue;
  //     }
  //   }
  //   super.initState();
  // }

  //Bottom sheet
  void _show(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (context) => Form(
        key: _dropdownFormKey,
        child: SafeArea(
          child: WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 50,
                          left: 25,
                          right: 25,
                          bottom:
                              MediaQuery.of(context).viewInsets.bottom + 15),
                      child: Container(
                        //color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Counts & Weights'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  splashColor: Colors.blue,
                                  splashRadius: 20.0,
                                  onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Warning'),
                                      content: const Text(
                                          'Are you sure you want to leave this page all unsaved entries will be lost.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _itemName = '';
                                            selectedCategory =
                                                "Select Category";
                                            controllerWeight.clear();
                                            controllerCount.clear();
                                            Navigator.pop(
                                              context,
                                              "This string will be passed back to the parent",
                                            );
                                            Navigator.pop(context, 'Yes');
                                          },
                                          //Navigator.pop(context, 'Yes'),
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.close,
                                  ),
                                ),
                                Text(
                                  '$itemRowCount',
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontFamily: 'ProximaNova',
                                    fontWeight: FontWeight.bold,
                                    //color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 8,
                            ),
                            DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                ),
                                validator: (value) => value == "Select Category"
                                    ? "Select Category"
                                    : null,
                                //dropdownColor: Colors.blueAccent,
                                value: selectedCategory,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCategory = newValue!;
                                  });
                                },
                                items: dropdownItems1),
                            const SizedBox(
                              height: 30,
                            ),
                            Autocomplete<String>(
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return const Iterable<String>.empty();
                                }

                                setState(() {
                                  _itemName = textEditingValue.text;
                                });

                                return _kOptionsItems
                                    .toSet()
                                    .where((String option) {
                                  return option.toTitleCase().contains(
                                      textEditingValue.text.toTitleCase());
                                });
                              },
                              fieldViewBuilder: ((context,
                                  textEditingController,
                                  focusNode,
                                  onFieldSubmitted) {
                                return TextFormField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  onEditingComplete: onFieldSubmitted,
                                  decoration: InputDecoration(
                                    hintText: 'Item Name',
                                    // prefixIcon: const Icon(
                                    //   Icons.pending_actions,
                                    // ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        textEditingController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Item Name";
                                    } else {
                                      return null;
                                    }
                                  },
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: controllerCount,
                              decoration: InputDecoration(
                                hintText: 'Total Count',
                                // prefixIcon: const Icon(
                                //   Icons.pending_actions,
                                // ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controllerCount.clear();
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Total Counts";
                                } else {
                                  if (int.parse(controllerCount.text) <= 0) {
                                    return "Total Counts can't be 0 or Less than 0";
                                  } else {
                                    return null;
                                  }
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: controllerWeight,
                              decoration: InputDecoration(
                                hintText: 'Total Weight',
                                // prefixIcon: const Icon(
                                //   Icons.auto_delete,
                                // ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controllerWeight.clear();
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Total Weight";
                                } else {
                                  if (int.parse(controllerWeight.text) < 0) {
                                    return "Total Weight can't be Less than 0";
                                  } else {
                                    return null;
                                  }
                                }
                              },
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        // _getUserLocation();
                                        // addItemToList();

                                        // print('$currentDate , '
                                        //     '${widget.countyID} , '
                                        //     '${widget.beachID}, '
                                        //     '$brandItem, '
                                        //     '$_manufacturerinputString, '
                                        //     '$_countryinputString, '
                                        //     '$selectedCategory, '
                                        //     '$selectedValue2, '
                                        //     '$selectedValue3, '
                                        //     '${controllerCounts.text}');

                                        if (_dropdownFormKey.currentState!
                                            .validate()) {
                                          //valid flow

                                          if (_itemName == null) {
                                          } else {
                                            splitagZone =
                                                widget.zone.split(" > ");

                                            addData();
                                            //-----------------------------------------------------------------------------------------------------
                                            setState(() {
                                              checkListItems.insert(
                                                  checkListItems.length, {
                                                "value": false,
                                                "title": _itemName,
                                                "Category":
                                                    widget.selectedCategoryTag,
                                                // "weight": itemWeight,
                                              });

                                              print(
                                                  '${splitagZone[1]} $_itemName ,$selectedCategory ,${controllerWeight.text} ,${controllerCount.text}');
                                              _itemName = '';
                                              selectedCategory =
                                                  "Select Category";
                                              controllerWeight.clear();
                                              controllerCount.clear();
                                            });
                                            //}
                                            Navigator.of(context).pop();

                                            Future.delayed(Duration.zero,
                                                () async {
                                              loader();
                                            });

                                            //selectedCategory = 'Select Category';
                                          }
                                        }
                                      },
                                      child: const Text("Save")),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Warning'),
            content: const Text(
                'Are you sure you want to leave this page all unsaved entries will be lost.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    "This string will be passed back to the parent",
                  );
                  Navigator.pop(context, 'Yes');
                },
                //Navigator.pop(context, 'Yes'),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  //Loader configurations
  Future<void> loader() async {
    OverlayLoadingProgress.start(context,
        gifOrImagePath: 'assets/loading.gif',
        barrierDismissible: true,
        widget: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: Colors.black38,
          color: darkBlue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: LoadingAnimationWidget.dotsTriangle(
                  size: 50,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const DefaultTextStyle(
                style: TextStyle(decoration: TextDecoration.none),
                child: Text(
                  'Marine Litter\nSDG',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ProximaNova',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
    await Future.delayed(const Duration(seconds: 1));
    OverlayLoadingProgress.stop();
  }

  String currentDate = DateFormat('d/M/yyyy').format(DateTime.now());

  void addData() {
    var url = "http://$ipAddress/sdg/counts/adddata.php";
    http.post(Uri.parse(url), body: {
      'Date': currentDate,
      'Location': widget.countyID.toTitleCase(),
      'BeachID': widget.beachID.toTitleCase(),
      'Transect': widget.transectID,
      'StartDry': widget.startDryGPS,
      'CenterDryWet': widget.centerGPS,
      'EndWet': widget.endWetGPS,
      'Zone': splitagZone[1],
      'Distance': '${widget.distanceInMeters}',
      'Category': selectedCategory.toTitleCase(),
      'Items': '$_itemName'.toTitleCase(),
      'Count': controllerCount.text,
      'Weight': controllerWeight.text,
    });
    //print('${controllerCounty.text} ${controllerBeach.text}');
    //print('$_itemName ,$selectedCategory ,${controllerWeight.text} ,${controllerCount.text}');
  }

  var itemRowCount;

  Future<List> getData() async {
    var url = "http://$ipAddress/sdg/kcounts/getdata.php";
    final response = await http.post(Uri.parse(url), body: {
      'transect': widget.transectID,
      'beachID': widget.beachID,
    });
    var responsedata = jsonDecode(response.body);

    setState(() {
      itemRowCount = responsedata.length;
    });
    return json.decode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      getData();
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadItems(context));
  }

  //Get autocomplete list filter data
  Future<List> getData_kOptionsItems() async {
    final response = await http.get(Uri.parse("http://$ipAddress/sdg/counts/getdata.php"));
    return json.decode(response.body);
  }

  //Load Item autocomplete textfield
  void _loadItems(BuildContext context) async {
    _http_kOptionsItems = await getData_kOptionsItems();
    //print(_http_kOptionsItems.toSet());

    setState(() {
      for (int i = 0; i < _http_kOptionsItems.length; i++) {
        _kOptionsItems.add(_http_kOptionsItems[i]['Items'].trim());
      }
    });

    //print(_kOptionsItems.toSet());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashColor: Colors.blue,
            splashRadius: 20.0,
            onPressed: () {
              if (_save_button_status == 'Saved') {
                Navigator.pop(
                  context,
                  "This string will be passed back to the parent",
                );
              } else {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Warning'),
                    content: const Text(
                        'Are you sure you want to leave this page all unsaved entries will be lost.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            "This string will be passed back to the parent",
                          );
                          Navigator.pop(context, 'Yes');
                        },
                        //Navigator.pop(context, 'Yes'),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          centerTitle: true,
          title: Text('${widget.transectID} > Counts & Weights'),
          actions: [
            Container(
              margin: const EdgeInsets.only(
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                '$itemRowCount',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'ProximaNova',
                  fontWeight: FontWeight.bold,
                  //color: Colors.black,
                ),
              )),
            ),
          ],
        ),
        //backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.all(20),
            controller: _controllerCheckboxTile,
            itemCount: checkListItems.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                checkboxShape: const CircleBorder(),
                activeColor: Colors.blue,
                dense: true,
                title: Text(
                  checkListItems[index]["title"],
                  style: const TextStyle(
                    fontSize: 16.0,
                    //color: Colors.black,
                  ),
                ),
                value: true,
                //checkListItems[index]["value"],
                onChanged: (value) {},
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 0.5,
                indent: 0,
                endIndent: 0,
              );
            },
          )),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: !changeColor,
                  child: Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _scrollDown();
                        _show(context);
                      },
                      child: const Text('Add Item'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
