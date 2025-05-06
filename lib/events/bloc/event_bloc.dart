import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/event_repository.dart';
import 'events_event.dart';
import 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventsRepository eventsRepository;

  EventsBloc(this.eventsRepository) : super(EventsInitial()) {
    on<FetchEvents>((event, emit) async {
      emit(EventsLoading());
      try {
        final events = await eventsRepository.fetchEvents();
        emit(EventsLoaded(events));
      } catch (e) {
        emit(EventsError(e.toString()));
      }
    });


    on<BookSlotEvent>((event, emit) async {
      try {
        await eventsRepository.bookSlot(eventId: event.eventId);
        final updatedEvents = await eventsRepository.fetchEvents();
        emit(EventsLoaded(updatedEvents));
      } catch (e) {
        emit(EventsError(e.toString()));
      }
    });

    on<CancelSlotEvent>((event, emit) async {
      try {
        await eventsRepository.cancelSlot(eventId: event.eventId);
        final updatedEvents = await eventsRepository.fetchEvents();
        emit(EventsLoaded(updatedEvents));
      } catch (e) {
        emit(EventsError(e.toString()));
      }
    });


  }
}
