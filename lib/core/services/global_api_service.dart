import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/country_data.dart';
import 'package:covid19_info/core/models/timeline_data.dart';

class GlobalApiService {
  static const String CORONA_STAT_BASE = 'https://api.coronastatistics.live/';

  Future<List<TimelineData>> fetchGlobalTimeline() async {
    try {
      http.Response res = await http.get(CORONA_STAT_BASE + 'timeline/global');
      final Map<String, dynamic> resMap = jsonDecode(res.body);
      final List<Map<String, dynamic>> timelineList =
          _flattenGlobalTimelineMap(resMap);
      return timelineList.map((m) => TimelineData.fromMap(m)).toList();
    } catch (e) {
      throw AppError(
        message: "Couldn't load timeline data!",
        error: e.toString(),
      );
    }
  }

  Future<List<CountryData>> fetchCountriesData() async {
    try {
      http.Response res =
          await http.get(CORONA_STAT_BASE + 'countries?sort=cases');
      final resMap = jsonDecode(res.body);
      return (resMap as List)
          .map((m) => CountryData.fromMap(m as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw AppError(
        message: "Couldn't load countries!",
        error: e.toString(),
      );
    }
  }

  Future<List<TimelineData>> fetchCountryTimeline(String code) async {
    try {
      http.Response res = await http.get(CORONA_STAT_BASE + 'timeline/$code');
      final List<Map<String, dynamic>> timeline =
          jsonDecode(res.body)['data']['timeline'];
      return timeline.map((m) => TimelineData.fromMap(m)).toList();
    } catch (e) {
      throw AppError(
        message: "Couldn't load timeline data!",
        error: e.toString(),
      );
    }
  }

  List<Map<String, dynamic>> _flattenGlobalTimelineMap(
      Map<String, dynamic> map) {
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
