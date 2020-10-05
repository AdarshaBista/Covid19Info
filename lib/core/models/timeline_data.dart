import 'package:meta/meta.dart';

class TimelineData {
  final int confirmed;
  final int deaths;
  final int recovered;
  final String date;

  TimelineData({
    @required this.confirmed,
    @required this.deaths,
    @required this.recovered,
    @required this.date,
  })  : assert(confirmed != null),
        assert(deaths != null),
        assert(recovered != null),
        assert(date != null);

  TimelineData copyWith({
    int confirmed,
    int deaths,
    int recovered,
    String date,
  }) {
    return TimelineData(
      confirmed: confirmed ?? this.confirmed,
      deaths: deaths ?? this.deaths,
      recovered: recovered ?? this.recovered,
      date: date ?? this.date,
    );
  }

  factory TimelineData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TimelineData(
      confirmed: map['confirmed'] as int,
      deaths: map['deaths'] as int,
      recovered: map['recovered'] as int,
      date: map['date'] as String,
    );
  }

  @override
  String toString() {
    return 'CountData(confirmed: $confirmed, deaths: $deaths, recovered: $recovered, date: $date)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TimelineData &&
        o.confirmed == confirmed &&
        o.deaths == deaths &&
        o.recovered == recovered &&
        o.date == date;
  }

  @override
  int get hashCode {
    return confirmed.hashCode ^ deaths.hashCode ^ recovered.hashCode ^ date.hashCode;
  }
}
