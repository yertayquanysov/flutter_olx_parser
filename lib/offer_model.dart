import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dataHtml;

class OfferModel {
  final String name;
  final String image;
  final String city;
  final int price;
  final int phoneNumber;

  OfferModel({
    @required this.name,
    @required this.image,
    this.price,
    this.phoneNumber,
    this.city,
  });

  static formDocument(dataHtml.Element data) {
    try {
      String offerName = data.getElementsByTagName("strong")[0].text;

      String offerImage =
          data.getElementsByTagName("img")[0].attributes.values.elementAt(1);

      return OfferModel(name: offerName, image: offerImage);
    } catch (e) {
      return OfferModel(name: e.toString(), image: "");
    }
  }
}
