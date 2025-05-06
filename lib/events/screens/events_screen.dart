import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/event_bloc.dart';
import '../bloc/events_event.dart';
import '../repository/event_repository.dart';
import '../widgets/events_item.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  String? _localId;

  @override
  void initState() {
    super.initState();
    _loadLocalId();
  }

  Future<void> _loadLocalId() async {
    final prefs = await SharedPreferences.getInstance();
    final localId = prefs.getString('localId');
    if (localId != null && localId.isNotEmpty) {
      setState(() {
        _localId = localId;
      });
    } else {
      print('localId not found or empty in SharedPreferences');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_localId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return BlocProvider(
      create: (_) => EventsBloc(EventsRepository())..add(FetchEvents()),
      child: EventsItem(localId: _localId!), // Now localId is properly passed
    );
  }
}

