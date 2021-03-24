import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:olx_parser/const.dart';
import 'package:olx_parser/model/cache.dart';
import 'package:olx_parser/model/parsed_data.dart';

abstract class IOlxRepository {}

class OlxRepository implements IOlxRepository {
  final List<Cache> cachedData = [];

  final client = http.Client();

  Future<String> getPageHTML(String url) async {
    final response = await client.get(Uri.parse(url), headers: {
      "cookie":
          "dfp_segment_test_v3=10; dfp_segment_test=59; dfp_segment_test_v4=87; dfp_segment_test_oa=89; _ym_uid=160302756521288000; _ym_d=1603027565; user_adblock_status=false; laquesissu=; __gads=ID=01c7cb79d96e3225:T=1603027565:S=ALNI_MaKJXY9FhuM-FDR2syVuCut1QQiFg; _ga=GA1.2.247289133.1603027565; tmr_lvid=1cb4df0848763f1b072ef8c3df94a7dd; tmr_lvidTS=1603027568732; lister_lifecycle=1603027606; dfp_user_id=a26c78fb-f89d-4408-aaf0-2bb3a75705e1-ver2; _gcl_au=1.1.1673659733.1611139480; cookieBarSeen=true; laquesisff=olxeu-29763#srt-627#srt-633#srt-635#srt-899; PHPSESSID=3eusk1h0oahf5tjdfou6qgddbj; lang=kk; criteo_hashed_email=a1b38ab0e9b782bbc51af86a2de9a2b7; __diug=true; refresh_token=78553f62504dfc1c215ade029555ba576ede2ae9; laquesis=buy-749@a#erm-215@b#erm-51@b; _hjid=d4e727f3-70ba-4f0b-80b1-12347fd81846; _gid=GA1.2.1449987610.1613750209; tmr_lvid=1cb4df0848763f1b072ef8c3df94a7dd; tmr_lvidTS=1603027568732; deviceGUID=a553348e-aacc-4f37-a400-f89ce6fd9533; grant_type=undefined; user_id=62658338; user_business_status=private; tmr_reqNum=233; __utmz=16996198.1613810858.17.5.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not provided); sbjs_migrations=1418474375998=1; sbjs_current_add=fd=2021-02-20 14:43:39|||ep=https://www.olx.kz/kk/myaccount/answers/|||rf=https://www.olx.kz/kk/myaccount/; sbjs_first_add=fd=2021-02-20 14:43:39|||ep=https://www.olx.kz/kk/myaccount/answers/|||rf=https://www.olx.kz/kk/myaccount/; sbjs_current=typ=typein|||src=(direct)|||mdm=(none)|||cmp=(none)|||cnt=(none)|||trm=(none); sbjs_first=typ=typein|||src=(direct)|||mdm=(none)|||cmp=(none)|||cnt=(none)|||trm=(none); sbjs_udata=vst=1|||uip=(none)|||uag=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36; session_start_date=1613816020699; mobile_default=desktop; fingerprint=MTI1NzY4MzI5MTsxMjswOzA7MDswOzA7MDswOzA7MDsxOzE7MTsxOzE7MTsxOzE7MTsxOzE7MTsxOzE7MDsxOzA7MDswOzA7MDswOzA7MDswOzA7MTsxOzE7MTswOzE7MDswOzA7MTswOzA7MDswOzA7MDswOzA7MDsxOzA7MDswOzA7MDswOzA7MTsxOzA7MDsxOzE7MDsxOzA7MDsyODk2MDA4NTI2OzI7MjsyOzI7MjsyOzM7MTIzNzY3NzU3OTsxNjU5NTg5NjQ5OzE7MTsxOzE7MTsxOzE7MTsxOzE7MTsxOzE7MTsxOzE7MTswOzE7MDs0MTAwMjE5OTs1MzgwOTg3Nzg7MTg0NzM0NDEzNTszMzA4Mzg4NDE7MzAyMTA1OTMzNjsxOTIwOzEwODA7MjQ7MjQ7MzAwOzMwMDszMDA7MzAwOzMwMDszMDA7MzAwOzMwMDszMDA7MzAwOzMwMDszMDA7MzAwOzMwMDszMDA7MzAwOzMwMDszMDA7MzAwOzMwMDswOzA7MA==; ldTd=true; __utmc=16996198; _ym_isad=2; access_token=f47165f7db765a79770cf0e3ab04awd48304e2ef37b; newrelic_cdn_name=CF; criteo_hashed_email_15=a1b38ab0e9b782bbc51af86a2de9a2b7; __utma=16996198.247289133.1603027565.1613849840.1613884777.20; __utmt=1; _ym_visorc=w; lqstatus=1613885977|177c0f245dbx313abbb8|buy-749||; _gat_clientNinja=1; from_detail=1; tmr_detect=0|1613884999315; tmr_reqNum=236; onap=1753be37abax5aa283b8-19-177c307612dx5ff28ab4-20-1613886806; __utmb=16996198.9.8.1613885008703"
    });

    final document = response.body;

    return document.toString();
  }

  Future<String?> getPhoneNumberToken(String url) async {
    try {
      final String html = await getPageHTML(url);
      return RegExp(patternPhoneNumberToken).firstMatch(html)!.group(0);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> getPhoneNumber(String url) async {
    try {
      final String? productId = getProductId(url);

      if (productId != null) {
        final String phoneToken = (await getPhoneNumberToken(url))!;

        final pnUrl = phoneNumberAjaxUrl
            .replaceAll("productId", productId)
            .replaceAll("phoneToken", phoneToken);

        var response = await client.get(Uri.parse(pnUrl), headers: {
          "cookie":
              "dfp_segment_test_v3=10; dfp_segment_test=59; dfp_segment_test_v4=87; dfp_segment_test_oa=89; _ym_uid=160302756521288000; _ym_d=1603027565; user_adblock_status=false; laquesissu=; __gads=ID=01c7cb79d96e3225:T=1603027565:S=ALNI_MaKJXY9FhuM-FDR2syVuCut1QQiFg; _ga=GA1.2.247289133.1603027565; tmr_lvid=1cb4df0848763f1b072ef8c3df94a7dd; tmr_lvidTS=1603027568732; lister_lifecycle=1603027606; dfp_user_id=a26c78fb-f89d-4408-aaf0-2bb3a75705e1-ver2; _gcl_au=1.1.1673659733.1611139480; cookieBarSeen=true; laquesisff=olxeu-29763#srt-627#srt-633#srt-635#srt-899; PHPSESSID=3eusk1h0oahf5tjdfou6qgddbj; lang=kk; criteo_hashed_email=a1b38ab0e9b782bbc51af86a2de9a2b7; __diug=true; refresh_token=78553f62504dfc1c215ade029555ba576ede2ae9; laquesis=buy-749@a#erm-215@b#erm-51@b; _hjid=d4e727f3-70ba-4f0b-80b1-12347fd81846; _gid=GA1.2.1449987610.1613750209; tmr_lvid=1cb4df0848763f1b072ef8c3df94a7dd; tmr_lvidTS=1603027568732; deviceGUID=a553348e-aacc-4f37-a400-f89ce6fd9533; grant_type=undefined; user_id=62658338; user_business_status=private; tmr_reqNum=233; __utmz=16996198.1613810858.17.5.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not provided); sbjs_migrations=1418474375998=1; sbjs_current_add=fd=2021-02-20 14:43:39|||ep=https://www.olx.kz/kk/myaccount/answers/|||rf=https://www.olx.kz/kk/myaccount/; sbjs_first_add=fd=2021-02-20 14:43:39|||ep=https://www.olx.kz/kk/myaccount/answers/|||rf=https://www.olx.kz/kk/myaccount/; sbjs_current=typ=typein|||src=(direct)|||mdm=(none)|||cmp=(none)|||cnt=(none)|||trm=(none); sbjs_first=typ=typein|||src=(direct)|||mdm=(none)|||cmp=(none)|||cnt=(none)|||trm=(none); sbjs_udata=vst=1|||uip=(none)|||uag=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36; session_start_date=1613816020699; mobile_default=desktop; fingerprint=MTI1NzY4MzI5MTsxMjswOzA7MDswOzA7MDswOzA7MDsxOzE7MTsxOzE7MTsxOzE7MTsxOzE7MTsxOzE7MDsxOzA7MDswOzA7MDswOzA7MDswOzA7MTsxOzE7MTswOzE7MDswOzA7MTswOzA7MDswOzA7MDswOzA7MDsxOzA7MDswOzA7MDswOzA7MTsxOzA7MDsxOzE7MDsxOzA7MDsyODk2MDA4NTI2OzI7MjsyOzI7MjsyOzM7MTIzNzY3NzU3OTsxNjU5NTg5NjQ5OzE7MTsxOzE7MTsxOzE7MTsxOzE7MTsxOzE7MTsxOzE7MTswOzE7MDs0MTAwMjE5OTs1MzgwOTg3Nzg7MTg0NzM0NDEzNTszMzA4Mzg4NDE7MzAyMTA1OTMzNjsxOTIwOzEwODA7MjQ7MjQ7MzAwOzMwMDszMDA7MzAwOzMwMDszMDA7MzAwOzMwMDszMDA7MzAwOzMwMDszMDA7MzAwOzMwMDszMDA7MzAwOzMwMDszMDA7MzAwOzMwMDswOzA7MA==; ldTd=true; __utmc=16996198; _ym_isad=2; access_token=f47165f7db765a79770cf0e3ab04awd48304e2ef37b; newrelic_cdn_name=CF; criteo_hashed_email_15=a1b38ab0e9b782bbc51af86a2de9a2b7; __utma=16996198.247289133.1603027565.1613849840.1613884777.20; __utmt=1; _ym_visorc=w; lqstatus=1613885977|177c0f245dbx313abbb8|buy-749||; _gat_clientNinja=1; from_detail=1; tmr_detect=0|1613884999315; tmr_reqNum=236; onap=1753be37abax5aa283b8-19-177c307612dx5ff28ab4-20-1613886806; __utmb=16996198.9.8.1613885008703"
        });

        return jsonDecode(response.body)["value"];
      }
    } catch (e) {
      return "";
    }
  }

  String? getProductId(String url) {
    try {
      return RegExp(patternProductCode)
          .firstMatch(url)!
          .group(0)!
          .replaceAll("ID", "");
    } catch (e) {
      print(e);
      return null;
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

      if (adsList[a] == adsList.last) {
        onFinish();
      }
    }
  }
}
