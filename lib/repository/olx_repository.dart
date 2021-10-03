import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:olx_parser/config.dart';
import 'package:olx_parser/model/cache.dart';
import 'package:olx_parser/model/parsed_data.dart';

abstract class IOlxRepository {}

class OlxRepository implements IOlxRepository {
  final List<Cache> cachedData = [];

  final client = http.Client();

  Future<String> getPageHTML(String url) async {
    final response =
        await client.get(Uri.parse(url), headers: defaultHttpHeader);

    return response.body.toString();
  }

  Future<String> getPhoneNumberToken(String url) async {
    try {
      final String html = await getPageHTML(url);
      return RegExp(patternPhoneNumberToken).firstMatch(html)?.group(0) ?? "";
    } catch (e) {
      logger.e("getPhoneNumberToken: " + e.toString());

      return "";
    }
  }

  Future<String> getPhoneNumber(String url) async {
    try {
      final String productId = getProductId(url);

      assert(productId.isNotEmpty, "Product id is null");

      final String phoneToken = await getPhoneNumberToken(url);

      final pnUrl = phoneNumberAjaxUrl
          .replaceAll("productId", productId)
          .replaceAll("phoneToken", phoneToken);

      final response =
          await client.get(Uri.parse(pnUrl), headers: defaultHttpHeader);

      logger.d("getPhoneNumber: " + response.toString());

      return jsonDecode(response.body)["value"];
    } catch (e) {
      logger.e("getPhoneNumber:" + e.toString());

      return "";
    }
  }

  String getProductId(String url) {
    try {
      return RegExp(patternProductCode)
          .firstMatch(url)!
          .group(0)!
          .replaceAll("ID", "");
    } catch (e) {
      logger.e("getProductId:" + e.toString());

      return "";
    }
  }

  Stream<ParsedData?> getAdsList({
    required url,
    required VoidCallback onFinish,
  }) async* {
    final String htmlData = await getPageHTML(url);
    final Document document = parse(htmlData);

    final adsList = document.getElementsByClassName("offer-wrapper").toList();

    for (int a = 0; a < adsList.length; a++) {
      yield await ParsedData.formDocument(adsList[a]);
    }

    onFinish();
  }
}
