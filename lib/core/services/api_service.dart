import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

import 'package:covid19_info/core/models/faq.dart';
import 'package:covid19_info/core/models/myth.dart';
import 'package:covid19_info/core/models/news.dart';
import 'package:covid19_info/core/models/podcast.dart';
import 'package:covid19_info/core/models/country.dart';
import 'package:covid19_info/core/models/district.dart';
import 'package:covid19_info/core/models/hospital.dart';
import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/nepal_stats.dart';
import 'package:covid19_info/core/models/timeline_data.dart';

import 'package:covid19_info/core/services/cache_service.dart';

class ApiService {
  final CacheService cacheService;

  const ApiService({
    @required this.cacheService,
  }) : assert(cacheService != null);

  List<Map<String, dynamic>> _flattenTimelineMap(Map<String, dynamic> map) {
    List<Map<String, dynamic>> list = [];
    map.forEach((k, v) {
      list.add({
        'date': k,
        ...v,
      });
    });
    return list;
  }

  static const String COVID_API_BASE = 'https://covidapi.info/api/v1/';
  static const String CORONA_TRACKER_BASE = 'https://api.coronatracker.com/';
  static const String NEPAL_CORONA_BASE = 'https://nepalcorona.info/api/v1/';
  static const String NEPAL_CORONA_DATA_BASE = 'https://data.nepalcorona.info/api/v1/';

  Future<NepalStats> fetchNepalStats() async {
    const String url = NEPAL_CORONA_BASE + 'data/nepal';
    final String cachedRes = await cacheService.get(url);
    if (cachedRes != null) {
      return NepalStats.fromMap(jsonDecode(cachedRes));
    }

    try {
      http.Response res = await http.get(url);
      await cacheService.insert(url, res.body);
      return NepalStats.fromMap(jsonDecode(res.body));
    } catch (e) {
      throw AppError(
        message: "Couldn't load nepal infection data!",
        error: e.toString(),
      );
    }
  }

  Future<List<TimelineData>> fetchNepalTimeline() async {
    const String url = COVID_API_BASE + 'country/NPL';
    final String cachedRes = await cacheService.get(url);
    if (cachedRes != null) {
      return _decodeNepalTimeline(cachedRes);
    }

    try {
      http.Response res = await http.get(url);
      await cacheService.insert(url, res.body);
      return _decodeNepalTimeline(res.body);
    } catch (e) {
      throw AppError(
        message: "Couldn't load Nepal timeline data!",
        error: e.toString(),
      );
    }
  }

  List<TimelineData> _decodeNepalTimeline(String data) {
    final Map<String, dynamic> resMap = jsonDecode(data)['result'];
    final List<Map<String, dynamic>> timelineList = _flattenTimelineMap(resMap);
    return timelineList.map((m) => TimelineData.fromMap(m)).toList();
  }

  Future<List<int>> fetchDistrictsIds() async {
    const String url = NEPAL_CORONA_DATA_BASE + 'districts';
    final String cachedRes = await cacheService.get(url);
    if (cachedRes != null) {
      return _decodeDistrictIds(cachedRes);
    }

    try {
      http.Response res = await http.get(url);
      await cacheService.insert(url, res.body);
      return _decodeDistrictIds(res.body);
    } catch (e) {
      throw AppError(
        message: "Couldn't load districts!",
        error: e.toString(),
      );
    }
  }

  List<int> _decodeDistrictIds(String data) {
    final List<dynamic> resList = jsonDecode(data);
    return resList.map((m) => m['id'] as int).toList();
  }

  Future<District> fetchDistrict(int id) async {
    final String url = NEPAL_CORONA_DATA_BASE + 'districts/$id';
    final String cachedRes = await cacheService.get(url);
    if (cachedRes != null) {
      return _decodeDistrict(cachedRes);
    }

    try {
      http.Response res = await http.get(url);
      await cacheService.insert(url, res.body);
      return _decodeDistrict(res.body);
    } catch (e) {
      throw AppError(
        message: "Couldn't load districts!",
        error: e.toString(),
      );
    }
  }

  District _decodeDistrict(String data) {
    final Map<String, dynamic> resMap = jsonDecode(data);
    if ((resMap['covid_cases'] as List).isEmpty) return null;
    return District.fromMap(resMap);
  }

  Future<List<News>> fetchNews(int start) async {
    final String url = NEPAL_CORONA_BASE + 'news?start=$start';
    final String cachedRes = await cacheService.get(url);
    if (cachedRes != null) {
      return _decodeNews(cachedRes);
    }

    try {
      http.Response res = await http.get(url);
      await cacheService.insert(url, res.body);
      return _decodeNews(res.body);
    } catch (e) {
      throw AppError(
        message: "Couldn't load news!",
        error: e.toString(),
      );
    }
  }

  List<News> _decodeNews(String data) {
    final Map<String, dynamic> resMap = jsonDecode(data);
    return (resMap['data'] as List).map((m) => News.fromMap(m)).toList();
  }

  Future<List<Myth>> fetchMyths(int start) async {
    final String url = NEPAL_CORONA_BASE + 'myths?start=$start';
    final String cachedRes = await cacheService.get(url);
    if (cachedRes != null) {
      return _decodeMyths(cachedRes);
    }

    try {
      http.Response res = await http.get(url);
      await cacheService.insert(url, res.body);
      return _decodeMyths(res.body);
    } catch (e) {
      throw AppError(
        message: "Couldn't load myths!",
        error: e.toString(),
      );
    }
  }

  List<Myth> _decodeMyths(String data) {
    final Map<String, dynamic> resMap = jsonDecode(data);
    return (resMap['data'] as List).map((m) => Myth.fromMap(m)).toList();
  }

  Future<List<Faq>> fetchFaqs(int start) async {
    final String url = NEPAL_CORONA_BASE + 'faqs?start=$start';
    final String cachedRes = await cacheService.get(url);
    if (cachedRes != null) {
      return _decodeFaqs(cachedRes);
    }

    try {
      http.Response res = await http.get(url);
      await cacheService.insert(url, res.body);
      return _decodeFaqs(res.body);
    } catch (e) {
      throw AppError(
        message: "Couldn't load FAQ!",
        error: e.toString(),
      );
    }
  }

  List<Faq> _decodeFaqs(String data) {
    Map<String, dynamic> resMap = jsonDecode(data) as Map<String, dynamic>;
    return (resMap['data'] as List).map((m) => Faq.fromMap(m)).toList();
  }

  Future<List<Podcast>> fetchPodcasts(int start) async {
    final String url = NEPAL_CORONA_BASE + 'podcasts?start=$start';
    final String cachedRes = await cacheService.get(url);
    if (cachedRes != null) {
      return _decodePodcasts(cachedRes);
    }

    try {
      http.Response res = await http.get(url);
      await cacheService.insert(url, res.body);
      return _decodePodcasts(res.body);
    } catch (e) {
      throw AppError(
        message: "Couldn't load Podcasts!",
        error: e.toString(),
      );
    }
  }

  List<Podcast> _decodePodcasts(String data) {
    Map<String, dynamic> resMap = jsonDecode(data) as Map<String, dynamic>;
    return (resMap['data'] as List).map((m) => Podcast.fromMap(m)).toList();
  }

  Future<List<Hospital>> fetchHospitals(int start) async {
    final String url = NEPAL_CORONA_BASE + 'hospitals?start=$start';
    final String cachedRes = await cacheService.get(url);
    if (cachedRes != null) {
      return _decodeHospitals(cachedRes);
    }

    try {
      http.Response res = await http.get(url);
      await cacheService.insert(url, res.body);
      return _decodeHospitals(res.body);
    } catch (e) {
      throw AppError(
        message: "Couldn't load hospital data!",
        error: e.toString(),
      );
    }
  }

  List<Hospital> _decodeHospitals(String data) {
    final Map<String, dynamic> resMap = jsonDecode(data);
    return (resMap['data'] as List).map((m) => Hospital.fromMap(m)).toList();
  }

  Future<List<TimelineData>> fetchGlobalTimeline() async {
    final String url = COVID_API_BASE + 'global/count';
    final String cachedRes = await cacheService.get(url);
    if (cachedRes != null) {
      return _decodeGlobalTimeline(cachedRes);
    }

    try {
      http.Response res = await http.get(url);
      await cacheService.insert(url, res.body);
      return _decodeGlobalTimeline(res.body);
    } catch (e) {
      throw AppError(
        message: "Couldn't load timeline data!",
        error: e.toString(),
      );
    }
  }

  List<TimelineData> _decodeGlobalTimeline(String data) {
    final Map<String, dynamic> resMap = jsonDecode(data)['result'];
    final List<Map<String, dynamic>> timelineList = _flattenTimelineMap(resMap);
    return timelineList.map((m) => TimelineData.fromMap(m)).toList();
  }

  Future<List<Country>> fetchCountries() async {
    final String url = CORONA_TRACKER_BASE + 'v3/stats/worldometer/country';
    final String cachedRes = await cacheService.get(url);
    if (cachedRes != null) {
      return _decodeCountries(cachedRes);
    }

    try {
      http.Response res = await http.get(url);
      await cacheService.insert(url, res.body);
      return _decodeCountries(res.body);
    } catch (e) {
      throw AppError(
        message: "Couldn't load countries!",
        error: e.toString(),
      );
    }
  }

  List<Country> _decodeCountries(String data) {
    final resMap = jsonDecode(data);
    return (resMap as List)
        .map((m) => Country.fromMap(m as Map<String, dynamic>))
        .toList();
  }

  Future<List<TimelineData>> fetchCountryTimeline(String code) async {
    final String url = COVID_API_BASE + 'country/$code';
    final String cachedRes = await cacheService.get(url);
    if (cachedRes != null) {
      return _decodeCountryTimeline(cachedRes);
    }

    try {
      http.Response res = await http.get(url);
      await cacheService.insert(url, res.body);
      return _decodeCountryTimeline(res.body);
    } catch (e) {
      throw AppError(
        message: "Couldn't load country timeline data!",
        error: e.toString(),
      );
    }
  }

  List<TimelineData> _decodeCountryTimeline(String data) {
    final Map<String, dynamic> resMap = jsonDecode(data)['result'];
    final List<Map<String, dynamic>> timelineList = _flattenTimelineMap(resMap);
    return timelineList.map((m) => TimelineData.fromMap(m)).toList();
  }
}
