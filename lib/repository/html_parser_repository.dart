import 'package:html/dom.dart' as dataHtml;

abstract class IHtmlParserRepository {
  String getPrice();

  String getName();

  String getImageUrl();

  String getCategoryName();

  String getAdsLink();

  String getCityName();
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
    var name = htmlData.getElementsByClassName("offer-path");
    return name[0].getElementsByTagName("small").first.text.trim();
  }

  @override
  String getCityName() {
    var data = htmlData.getElementsByClassName("bottom-cell");
    return data[0].getElementsByTagName("span").first.text;
  }

  @override
  String getPrice() {
    var data = htmlData.getElementsByClassName("price");
    return data[0].getElementsByTagName("strong").first.text;
  }

  @override
  String getAdsLink() {
    var data = htmlData.getElementsByTagName("h3");
    return data[0].getElementsByTagName("a").first.attributes.values.first;
  }
}
