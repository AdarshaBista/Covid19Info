import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:covid19_info/core/services/api_service.dart';

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/faq.dart';
import 'package:covid19_info/core/models/myth.dart';
import 'package:covid19_info/core/models/news.dart';
import 'package:covid19_info/core/models/hospital.dart';
import 'package:covid19_info/core/models/nepal_stats.dart';
import 'package:covid19_info/core/models/timeline_data.dart';

class NepalApiService extends ApiService {
  static const String COVID_API_BASE = 'https://covidapi.info/api/v1/';
  static const String NEPAL_CORONA_BASE = 'https://nepalcorona.info/api/v1/';

  Future<NepalStats> fetchNepalStats() async {
    try {
      http.Response res = await http.get(NEPAL_CORONA_BASE + 'data/nepal');
      return NepalStats.fromMap(jsonDecode(res.body));
    } catch (e) {
      throw AppError(
        message: "Couldn't load nepal infection data!",
        error: e.toString(),
      );
    }
  }

  Future<List<TimelineData>> fetchNepalTimeline() async {
    try {
      http.Response res = await http.get(COVID_API_BASE + 'country/NPL');
      final Map<String, dynamic> resMap = jsonDecode(res.body)['result'];
      final List<Map<String, dynamic>> timelineList = flattenTimelineMap(resMap);
      return timelineList.map((m) => TimelineData.fromMap(m)).toList();
    } catch (e) {
      throw AppError(
        message: "Couldn't load Nepal timeline data!",
        error: e.toString(),
      );
    }
  }

  Future<List<News>> fetchNews(int start) async {
    try {
      http.Response res = await http.get(NEPAL_CORONA_BASE + 'news?start=$start');
      final Map<String, dynamic> resMap = jsonDecode(res.body);
      return (resMap['data'] as List).map((m) => News.fromMap(m)).toList();
    } catch (e) {
      throw AppError(
        message: "Couldn't load news!",
        error: e.toString(),
      );
    }
  }

  Future<List<Myth>> fetchMyths(int start) async {
    try {
      http.Response res = await http.get(NEPAL_CORONA_BASE + 'myths?start=$start');
      final Map<String, dynamic> resMap = jsonDecode(res.body);
      return (resMap['data'] as List).map((m) => Myth.fromMap(m)).toList();
    } catch (e) {
      throw AppError(
        message: "Couldn't load myths!",
        error: e.toString(),
      );
    }
  }

  Future<List<Faq>> fetchFaqs(int start) async {
    try {
      http.Response res = await http.get(NEPAL_CORONA_BASE + 'faqs?start=$start');
      Map<String, dynamic> resMap = jsonDecode(res.body) as Map<String, dynamic>;
      return (resMap['data'] as List).map((m) => Faq.fromMap(m)).toList();
    } catch (e) {
      throw AppError(
        message: "Couldn't load FAQ!",
        error: e.toString(),
      );
    }
  }

  Future<List<Hospital>> fetchHospitals(int start) async {
    try {
      http.Response res = await http.get(NEPAL_CORONA_BASE + 'hospitals?start=$start');
      final Map<String, dynamic> resMap = jsonDecode(res.body);
      return (resMap['data'] as List).map((m) => Hospital.fromMap(m)).toList();
    } catch (e) {
      throw AppError(
        message: "Couldn't load hospital data!",
        error: e.toString(),
      );
    }
  }
}
