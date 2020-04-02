import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/country.dart';
import 'package:covid19_info/core/models/global_stats.dart';

class GlobalApiService {
  static const String COVID_API_BASE = 'https://covidapi.info/api/v1/';
  static const String CORONA_STAT_BASE = 'https://api.coronastatistics.live/';

  // TODO: Refactor this mess
  Future<GlobalStats> fetchGlobalStats() async {
    try {
      http.Response countRes = await http.get(COVID_API_BASE + 'global');
      final globalCountMap = jsonDecode(countRes.body)['result'];

      http.Response timelineRes =
          await http.get(COVID_API_BASE + 'global/count');
      final Map<String, dynamic> timelineMap =
          jsonDecode(timelineRes.body)['result'];
      final List<Map<String, dynamic>> timeline = [];
      timelineMap.forEach((key, value) {
        timeline.add({'date': key, ...value});
      });

      final Map<String, dynamic> map = {
        ...globalCountMap,
        'timeline': timeline,
      };

      return GlobalStats.fromMap(map);
    } catch (e) {
      throw AppError(
        message: "Couldn't load global stats!",
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
}
