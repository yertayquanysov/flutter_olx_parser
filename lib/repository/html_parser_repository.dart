import 'package:html/dom.dart' as dataHtml;

abstract class IHtmlParserRepository {
  String getPrice();

  String getName();

  String getImageUrl();

  String getCategoryName();

  String getAdsLink();

  String getCityName();

  String getDate();
}

class HtmlParserRepository implements IHtmlParserRepository {
  final dataHtml.Element htmlData;

  HtmlParserRepository(this.htmlData);

  @override
  String getName() {
    var name = htmlData.getElementsByTagName("h3");
    return name[0].getElementsByTagName("strong").first.text;
  }

  @override
  String getImageUrl() {
    return htmlData
        .getElementsByTagName("img")[0]
        .attributes
        .values
        .elementAt(1);
  }

  @override
  String getCategoryName() {
    final name = htmlData.getElementsByClassName("offer-path");
    return name[0].getElementsByTagName("small").first.text.trim();
  }

  @override
  String getCityName() {
    final data = htmlData.getElementsByClassName("bottom-cell");
    return data[0].getElementsByTagName("span").first.text;
  }

  @override
  String getPrice() {
    final data = htmlData.getElementsByClassName("price");
    return data[0].getElementsByTagName("strong").first.text;
  }

  @override
  String getAdsLink() {
    final data = htmlData.getElementsByTagName("h3");
    return data[0].getElementsByTagName("a").first.attributes.values.first;
  }

  @override
  String getDate() {
    final data = htmlData.getElementsByClassName("bottom-cell");
    return data[0].getElementsByTagName("span")[1].text;
  }
}
