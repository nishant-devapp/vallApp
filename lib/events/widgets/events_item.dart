import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/event_bloc.dart';
import '../bloc/events_event.dart';
import '../bloc/events_state.dart';

class EventsItem extends StatelessWidget {
  const EventsItem({super.key, required this.localId});

  final String localId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: BlocBuilder<EventsBloc, EventsState>(
        builder: (context, state) {
          if (state is EventsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventsLoaded) {
            final documents = state.events.documents ?? [];
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final event = documents[index];
                final title = event.fields?.title?.stringValue ?? 'No Title';
                final description = event.fields?.description?.stringValue ?? 'No Description';
                final totalBookings = event.fields?.totalBookedCount?.integerValue ?? 0;
                final date = event.fields?.date?.stringValue ?? 'No Date';

                final bookedUsers = event.fields?.bookedUsers?.arrayValue?.values
                    ?.map((e) => e.stringValue ?? "")
                    .toList() ?? [];

               // print(bookedUsers);

                final userHasBooked = bookedUsers.contains(localId);

                final fullPath = event.name;
                //print(fullPath);
                final eventId = fullPath?.split('/').last ?? '';

                //print(eventId);
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(description),
                        const SizedBox(height: 4),
                        Text('Date: $date', style: TextStyle(fontSize: 16.0, color: Colors.blue, fontWeight: FontWeight.w500),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Bookings: $totalBookings', style: TextStyle(fontSize: 16.0, color: Colors.teal, fontWeight: FontWeight.w500),),
                            Align(alignment: AlignmentDirectional.centerEnd,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: userHasBooked ? Colors.red : Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  if (userHasBooked) {
                                    context.read<EventsBloc>().add(CancelSlotEvent(eventId, localId));
                                  } else {
                                    context.read<EventsBloc>().add(BookSlotEvent(eventId, localId));
                                  }
                                },
                                child: Text(userHasBooked ? "Cancel Slot" : "Book Slot"),
                              ),)
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is EventsError) {
           // print('Error: ${state.message}');
            return Center(child: Text('Error: ${state.message}'));
          }
          else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
