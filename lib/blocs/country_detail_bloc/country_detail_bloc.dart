import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:covid19_info/core/models/country.dart';
import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/timeline_data.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'country_detail_event.dart';
part 'country_detail_state.dart';

class CountryDetailBloc extends Bloc<CountryDetailEvent, CountryDetailState> {
  final ApiService apiService;
  final Map<String, Country> _countriesCache = {};

  CountryDetailBloc({
    @required this.apiService,
  })  : assert(apiService != null),
        super(const InitialCountryDetailState());

  @override
  Stream<CountryDetailState> mapEventToState(
    CountryDetailEvent event,
  ) async* {
    if (event is GetCountryDetailEvent) {
      if (_countriesCache.containsKey(event.country.code)) {
        yield LoadedCountryDetailState(country: _countriesCache[event.country.code]);
        return;
      }

      yield const LoadingCountryDetailState();
      try {
        final List<TimelineData> timeline =
            await apiService.fetchCountryTimeline(countryISOMapping[event.country.code]);
        final Country country = event.country.copyWith(timeline: timeline);
        _countriesCache[country.code] = country;
        yield LoadedCountryDetailState(country: country);
      } on AppError catch (e) {
        print(e.error);
        yield ErrorCountryDetailState(message: e.message);
      }
    }
  }
}

const Map<String, String> countryISOMapping = {
  'AF': 'AFG',
  'AX': 'ALA',
  'AL': 'ALB',
  'DZ': 'DZA',
  'AS': 'ASM',
  'AD': 'AND',
  'AO': 'AGO',
  'AI': 'AIA',
  'AQ': 'ATA',
  'AG': 'ATG',
  'AR': 'ARG',
  'AM': 'ARM',
  'AW': 'ABW',
  'AU': 'AUS',
  'AT': 'AUT',
  'AZ': 'AZE',
  'BS': 'BHS',
  'BH': 'BHR',
  'BD': 'BGD',
  'BB': 'BRB',
  'BY': 'BLR',
  'BE': 'BEL',
  'BZ': 'BLZ',
  'BJ': 'BEN',
  'BM': 'BMU',
  'BT': 'BTN',
  'BO': 'BOL',
  'BA': 'BIH',
  'BW': 'BWA',
  'BV': 'BVT',
  'BR': 'BRA',
  'VG': 'VGB',
  'IO': 'IOT',
  'BN': 'BRN',
  'BG': 'BGR',
  'BF': 'BFA',
  'BI': 'BDI',
  'KH': 'KHM',
  'CM': 'CMR',
  'CA': 'CAN',
  'CV': 'CPV',
  'KY': 'CYM',
  'CF': 'CAF',
  'TD': 'TCD',
  'CL': 'CHL',
  'CN': 'CHN',
  'HK': 'HKG',
  'MO': 'MAC',
  'CX': 'CXR',
  'CC': 'CCK',
  'CO': 'COL',
  'KM': 'COM',
  'CG': 'COG',
  'CD': 'COD',
  'CK': 'COK',
  'CR': 'CRI',
  'CI': 'CIV',
  'HR': 'HRV',
  'CU': 'CUB',
  'CY': 'CYP',
  'CZ': 'CZE',
  'DK': 'DNK',
  'DJ': 'DJI',
  'DM': 'DMA',
  'DO': 'DOM',
  'EC': 'ECU',
  'EG': 'EGY',
  'SV': 'SLV',
  'GQ': 'GNQ',
  'ER': 'ERI',
  'EE': 'EST',
  'ET': 'ETH',
  'FK': 'FLK',
  'FO': 'FRO',
  'FJ': 'FJI',
  'FI': 'FIN',
  'FR': 'FRA',
  'GF': 'GUF',
  'PF': 'PYF',
  'TF': 'ATF',
  'GA': 'GAB',
  'GM': 'GMB',
  'GE': 'GEO',
  'DE': 'DEU',
  'GH': 'GHA',
  'GI': 'GIB',
  'GR': 'GRC',
  'GL': 'GRL',
  'GD': 'GRD',
  'GP': 'GLP',
  'GU': 'GUM',
  'GT': 'GTM',
  'GG': 'GGY',
  'GN': 'GIN',
  'GW': 'GNB',
  'GY': 'GUY',
  'HT': 'HTI',
  'HM': 'HMD',
  'VA': 'VAT',
  'HN': 'HND',
  'HU': 'HUN',
  'IS': 'ISL',
  'IN': 'IND',
  'ID': 'IDN',
  'IR': 'IRN',
  'IQ': 'IRQ',
  'IE': 'IRL',
  'IM': 'IMN',
  'IL': 'ISR',
  'IT': 'ITA',
  'JM': 'JAM',
  'JP': 'JPN',
  'JE': 'JEY',
  'JO': 'JOR',
  'KZ': 'KAZ',
  'KE': 'KEN',
  'KI': 'KIR',
  'KP': 'PRK',
  'KR': 'KOR',
  'KW': 'KWT',
  'KG': 'KGZ',
  'LA': 'LAO',
  'LV': 'LVA',
  'LB': 'LBN',
  'LS': 'LSO',
  'LR': 'LBR',
  'LY': 'LBY',
  'LI': 'LIE',
  'LT': 'LTU',
  'LU': 'LUX',
  'MK': 'MKD',
  'MG': 'MDG',
  'MW': 'MWI',
  'MY': 'MYS',
  'MV': 'MDV',
  'ML': 'MLI',
  'MT': 'MLT',
  'MH': 'MHL',
  'MQ': 'MTQ',
  'MR': 'MRT',
  'MU': 'MUS',
  'YT': 'MYT',
  'MX': 'MEX',
  'FM': 'FSM',
  'MD': 'MDA',
  'MC': 'MCO',
  'MN': 'MNG',
  'ME': 'MNE',
  'MS': 'MSR',
  'MA': 'MAR',
  'MZ': 'MOZ',
  'MM': 'MMR',
  'NA': 'NAM',
  'NR': 'NRU',
  'NP': 'NPL',
  'NL': 'NLD',
  'AN': 'ANT',
  'NC': 'NCL',
  'NZ': 'NZL',
  'NI': 'NIC',
  'NE': 'NER',
  'NG': 'NGA',
  'NU': 'NIU',
  'NF': 'NFK',
  'MP': 'MNP',
  'NO': 'NOR',
  'OM': 'OMN',
  'PK': 'PAK',
  'PW': 'PLW',
  'PS': 'PSE',
  'PA': 'PAN',
  'PG': 'PNG',
  'PY': 'PRY',
  'PE': 'PER',
  'PH': 'PHL',
  'PN': 'PCN',
  'PL': 'POL',
  'PT': 'PRT',
  'PR': 'PRI',
  'QA': 'QAT',
  'RE': 'REU',
  'RO': 'ROU',
  'RU': 'RUS',
  'RW': 'RWA',
  'BL': 'BLM',
  'SH': 'SHN',
  'KN': 'KNA',
  'LC': 'LCA',
  'MF': 'MAF',
  'PM': 'SPM',
  'VC': 'VCT',
  'WS': 'WSM',
  'SM': 'SMR',
  'ST': 'STP',
  'SA': 'SAU',
  'SN': 'SEN',
  'RS': 'SRB',
  'SC': 'SYC',
  'SL': 'SLE',
  'SG': 'SGP',
  'SK': 'SVK',
  'SI': 'SVN',
  'SB': 'SLB',
  'SO': 'SOM',
  'ZA': 'ZAF',
  'GS': 'SGS',
  'SS': 'SSD',
  'ES': 'ESP',
  'LK': 'LKA',
  'SD': 'SDN',
  'SR': 'SUR',
  'SJ': 'SJM',
  'SZ': 'SWZ',
  'SE': 'SWE',
  'CH': 'CHE',
  'SY': 'SYR',
  'TW': 'TWN',
  'TJ': 'TJK',
  'TZ': 'TZA',
  'TH': 'THA',
  'TL': 'TLS',
  'TG': 'TGO',
  'TK': 'TKL',
  'TO': 'TON',
  'TT': 'TTO',
  'TN': 'TUN',
  'TR': 'TUR',
  'TM': 'TKM',
  'TC': 'TCA',
  'TV': 'TUV',
  'UG': 'UGA',
  'UA': 'UKR',
  'AE': 'ARE',
  'GB': 'GBR',
  'US': 'USA',
  'UM': 'UMI',
  'UY': 'URY',
  'UZ': 'UZB',
  'VU': 'VUT',
  'VE': 'VEN',
  'VN': 'VNM',
  'VI': 'VIR',
  'WF': 'WLF',
  'EH': 'ESH',
  'YE': 'YEM',
  'ZM': 'ZMB',
  'ZW': 'ZWE',
  'XK': 'XKX'
};
