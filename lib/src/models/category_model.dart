import 'package:sdg/src/constants/image_strings.dart';

class CategoryModel {
  final String title;
  final int totalCount;
  final int totalWeight;
  final String pictures;

  CategoryModel(
      this.title, this.totalCount, this.totalWeight, this.pictures);

  static List<CategoryModel> category = [
    // CategoryModel('Construction', 0, 0, contruction),
    // CategoryModel('Plastic', 0, 0, plasticwaste),
    // CategoryModel('Rubber', 0, 0, rubberwaste),
    // CategoryModel('Hygiene', 0, 0, hygienewaste),
    // CategoryModel('Metal', 0, 0, metal),
    // CategoryModel('Glass',0, 0, glass),
    // CategoryModel('Paper & Cardboard',0, 0, cardboard),
    // CategoryModel('Marine & Fishing',0, 0, fishing),
    // CategoryModel('Clothing - Covid',0, 0, covidmask),
    // CategoryModel('Clothing', 0, 0, clothings),
    // CategoryModel('E - Waste', 0, 0, electronics),
    // CategoryModel('Processed wood',0, 0, processedwood),
    // CategoryModel('Foam',0, 0, processedwood),
    // CategoryModel('Other', 0, 0, otherwaste),

    //=====================================================================================================Android
    CategoryModel('Count & Weights',0, 0, 'assets/itemclasses/countertime.png'),
    CategoryModel('Brand Audit',0, 0, 'assets/itemclasses/branded.png'),
    CategoryModel('Count & Weights Data', 0, 0,'assets/itemclasses/countlist.png' ),
    CategoryModel('Brand Audit Data', 0, 0, 'assets/itemclasses/brandlist.png'),

    //=====================================================================================================Web
    // CategoryModel('Count & Weights',0, 0, 'https://mspwarehouse.s3.amazonaws.com/countertime.png'),
    // CategoryModel('Brand Audit',0, 0, 'https://mspwarehouse.s3.amazonaws.com/branded.png'),
    // CategoryModel('Count & Weights Data', 0, 0, 'https://mspwarehouse.s3.amazonaws.com/countlist.png'),
    // CategoryModel('Brand Audit Data', 0, 0, 'https://mspwarehouse.s3.amazonaws.com/brandlist.png'),
  ];
}

// Building & Construction
// Carbon fibre
// Clothing
// COVID-19 Related
// E-Waste
// Fabric
// Foam
//
// Hygiene
// Marine & Fishing gear
// Others
//
// Paper & Cardboard
// Personal care
// Porcelain
// Processed wood
//
//
// Wood & Cardboard
