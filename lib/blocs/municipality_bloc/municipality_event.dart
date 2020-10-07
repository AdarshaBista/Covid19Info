part of 'municipality_bloc.dart';

@immutable
abstract class MunicipalityEvent {
  const MunicipalityEvent();
}

class GetMunicipalityEvent extends MunicipalityEvent {
  final List<int> ids;

  const GetMunicipalityEvent({
    @required this.ids,
  }) : assert(ids != null);
}
