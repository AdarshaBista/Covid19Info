import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/country.dart';
import 'package:covid19_info/core/models/timeline_data.dart';

class GlobalApiService {
  static const String CORONA_STAT_BASE = 'https://api.coronastatistics.live/';

  Future<List<TimelineData>> fetchGlobalTimeline() async {
    try {
      http.Response res = await http.get(CORONA_STAT_BASE + 'timeline/global');
      final Map<String, dynamic> resMap = jsonDecode(res.body);
      final List<Map<String, dynamic>> timelineList = flattenMap(resMap);
      return timelineList.map((m) => TimelineData.fromMap(m)).toList();
    } catch (e) {
      throw AppError(
        message: "Couldn't load timeline data!",
        error: e.toString(),
      );
    }
  }

  Future<List<Country>> fetchCountries() async {
    try {
      http.Response res =
          await http.get(CORONA_STAT_BASE + 'countries?sort=cases');
      final Map<String, dynamic> resMap = jsonDecode(res.body);
      return (resMap['data'] as List).map((m) => Country.fromMap(m)).toList();
    } catch (e) {
      throw AppError(
        message: "Couldn't load countries!",
        error: e.toString(),
      );
    }
  }

  List<Map<String, dynamic>> flattenMap(Map<String, dynamic> map) {
    List<Map<String, dynamic>> list = [];
    map.forEach((k, v) {
      list.add({
        'date': k,
        ...v,
      });
    });
    return list;
  }
}
