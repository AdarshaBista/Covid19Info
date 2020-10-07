part of 'myth_bloc.dart';

@immutable
abstract class MythEvent {
  const MythEvent();
}

class GetMythsEvent extends MythEvent {
  const GetMythsEvent();
}
