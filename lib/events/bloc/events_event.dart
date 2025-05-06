import 'package:equatable/equatable.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class FetchEvents extends EventsEvent {}


class BookSlotEvent extends EventsEvent {
  final String eventId;
  final String localId;

  const BookSlotEvent(this.eventId, this.localId);

  @override
  List<Object> get props => [eventId, localId];
}

class CancelSlotEvent extends EventsEvent {
  final String eventId;
  final String localId;

  const CancelSlotEvent(this.eventId, this.localId);

  @override
  List<Object> get props => [eventId, localId];
}

