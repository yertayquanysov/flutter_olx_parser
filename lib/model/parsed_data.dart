import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ParsedData {
  final String name;
  final String price;
  final String phoneNumber;
  final String offerUrl;
  final String date;
  final String city;
  final String imageUrl;
  final String sellerName;
  final String categoryName;

  ParsedData({
    this.name,
    this.price,
    this.phoneNumber,
    this.city,
    this.offerUrl,
    this.date,
    this.imageUrl,
    this.sellerName,
    this.categoryName,
  });

  Map<String, Object> toDocument() {
    return {
      "name": name,
      "price": price,
      "phoneNumber": phoneNumber,
      "offerUrl": offerUrl,
      "date": date,
      "city": city,
      "imageUrl": imageUrl,
      "sellerName": sellerName,
      "categoryName": categoryName,
    };
  }
}

class ParsedDataSource extends DataGridSource<ParsedData> {
  final List<ParsedData> adsList = [
    ParsedData(
      name: "Телефон сатылады",
      price: "8700 тг",
      imageUrl:
          "https://cdn.pixabay.com/photo/2021/02/03/17/36/river-5978743_960_720.jpg",
      phoneNumber: "8 705 895 86 92",
      sellerName: "Ertai",
    ),
    ParsedData(
      name: "Телефон сатылады",
      price: "8700 тг",
      imageUrl:
          "https://cdn.pixabay.com/photo/2021/02/03/17/36/river-5978743_960_720.jpg",
      phoneNumber: "8 705 895 86 92",
      sellerName: "Ertai",
    ),
    ParsedData(
      name: "Телефон сатылады",
      price: "8700 тг",
      imageUrl:
          "https://cdn.pixabay.com/photo/2021/02/03/17/36/river-5978743_960_720.jpg",
      phoneNumber: "8 705 895 86 92",
      sellerName: "Ertai",
    ),
    ParsedData(
      name: "Телефон сатылады",
      price: "8700 тг",
      imageUrl:
          "https://cdn.pixabay.com/photo/2021/02/03/17/36/river-5978743_960_720.jpg",
      phoneNumber: "8 705 895 86 92",
      sellerName: "Ertai",
    ),
  ];

  @override
  List<ParsedData> get dataSource => adsList;

  @override
  bool shouldRecalculateColumnWidths() {
    return true;
  }

  @override
  getValue(ParsedData data, String columnName) {
    try {
      return data.toDocument()[columnName];
    } catch (e) {
      return "";
    }
  }
}
