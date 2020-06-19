import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:covid19_info/core/models/district.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/nepal_district_bloc/nepal_district_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/map_card.dart';
import 'package:covid19_info/ui/widgets/common/search_box.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';
import 'package:covid19_info/ui/widgets/nepal_page/district_details.dart';

class NepalMapCard extends StatelessWidget {
  const NepalMapCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NepalDistrictBloc, NepalDistrictState>(
      builder: (context, state) {
        if (state is InitialDistrictState) {
          return const EmptyIcon();
        } else if (state is LoadedDistrictState) {
          return Stack(
            children: [
              _buildMap(state),
              if (state.shouldShowSearch) _buildDistrictSearchBox(context),
            ],
          );
        } else if (state is ErrorDistrictState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildMap(LoadedDistrictState state) {
    return MapCard(
      center: LatLng(27.728201, 85.347351),
      zoom: 7.0,
      minZoom: 7.0,
      maxZoom: 10.0,
      nePanBoundary: LatLng(29.5, 88.8),
      swPanBoundary: LatLng(26.5, 80.0),
      markerLayerBuilder: () => _buildMarkers(state),
      searchLocation: () {
        if (!state.shouldShowAllDistricts && !state.isSearchEmpty)
          return LatLng(
            state.searchedDistricts.first.lat,
            state.searchedDistricts.first.lng,
          );
        return null;
      },
    );
  }

  MarkerLayerOptions _buildMarkers(LoadedDistrictState state) {
    return MarkerLayerOptions(
      markers: state.allDistricts.map(
        (d) {
          double diameter =
              (math.sqrt(d.cases.length.toDouble()) * 6.0).clamp(16.0, 64.0);
          return Marker(
            height: diameter,
            width: diameter,
            point: LatLng(d.lat, d.lng),
            builder: (context) => GestureDetector(
              onTap: () => _openDetails(context, d),
              child: CircleAvatar(
                backgroundColor: state.isDistrictInSearch(d)
                    ? Colors.blue.withOpacity(0.6)
                    : Colors.red.withOpacity(0.6),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  void _openDetails(BuildContext context, District d) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      elevation: 12.0,
      backgroundColor: AppColors.dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: DistrictDetails(
            district: d,
          ),
        );
      },
    );
  }

  Widget _buildDistrictSearchBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBox(
        hintText: 'Search Districts',
        onChanged: (String value) {
          context.bloc<NepalDistrictBloc>()
            ..add(SearchDistrictEvent(
              searchTerm: value,
            ));
        },
      ),
    );
  }
}
