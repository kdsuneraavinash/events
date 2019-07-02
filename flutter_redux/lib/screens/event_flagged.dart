import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:event_app/state/flagged.dart';
import 'package:event_app/redux_store/store.dart';
import 'package:event_app/screens/event_flagged/event_flagged_card.dart';

/// Window to show pinned events to toggle alarms
/// TODO: Add notifications on Alarm times
class FlaggedEventManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pinned Events"),
      ),
      body: StoreConnector<EventState, EventState>(
        converter: (store) => store.state,
        builder: (context, eventStore) =>
            _buildAlarmButtons(eventStore.flaggedList),
      ),
    );
  }

  Widget _buildAlarmButtons(List<FlaggedEvent> alarmList) {
    List<Widget> list = [];
    for (FlaggedEvent alarm in alarmList) {
      list.add(EventFlaggedCard(alarm));
    }

    if (list.isEmpty) {
      return Center(child: Text("Pin events and they will show up here."));
    } else {
      return ListView.builder(
        itemBuilder: (_, index) => list[index],
        itemCount: list.length,
      );
    }
  }
}
