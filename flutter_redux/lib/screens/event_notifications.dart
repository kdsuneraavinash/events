import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:event_app/redux_store/actions.dart' as Actions;
import 'package:event_app/redux_store/store.dart';
import 'package:event_app/state/notification.dart';

/// [EventNotificationsManager] which will connect to [StoreBuilder].
class EventNotificationsManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<EventState>(
      builder: buildEventNotificationsManager,
    );
  }

  /// Builds main page.
  Widget buildEventNotificationsManager(
      BuildContext context, Store<EventState> eventStore) {
    List<Widget> listViewChildren =
        _buildListViewChildren(context, eventStore.state);
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => eventStore.dispatch(Actions.ClearNotifications()),
          )
        ],
      ),
      body: listViewChildren.isEmpty
          ? Center(child: Text("Nothing Here"))
          : ListView.builder(
              itemBuilder: (_, index) => listViewChildren[index],
              itemCount: listViewChildren.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => eventStore.dispatch(Actions.MarkNotificationsAsRead()),
        child: Icon(Icons.done_all),
      ),
    );
  }

  /// Build the notification list Children
  List<Widget> _buildListViewChildren(
      BuildContext context, EventState eventState) {
    ThemeData currentTheme = Theme.of(context);
    List<Widget> listViewChildren = [];

    /// Get every Notification and build the notification by that data
    for (EventNotification notification in eventState.notifications.reversed) {
      listViewChildren.add(ListTile(
        leading: CircleAvatar(
          child: Icon(
            notification.getIcon(),
            color: currentTheme.scaffoldBackgroundColor,
          ),
          backgroundColor:
              notification.read ? Colors.grey : currentTheme.primaryColor,
        ),
        title: Text(
          notification.message,
          style:
              TextStyle(fontWeight: notification.read ? FontWeight.w400 : null),
        ),
        subtitle: Text(
          getMessageByDate(notification.timestamp),
          style: TextStyle(
            color: notification.read ? null : currentTheme.accentColor,
          ),
        ),
      ));
    }
    return listViewChildren;
  }

  /// Creates a message like 'Just Now', '15 minutes ago' ...
  /// using a timestamp
  String getMessageByDate(DateTime timestamp) {
    DateTime now = DateTime.now();
    Duration diff = now.difference(timestamp);
    if (diff.inDays == 0) {
      if (diff.inHours == 0) {
        if (diff.inMinutes == 0) {
          if (diff.inSeconds <= 15) {
            return "Just now";
          }
          return "${diff.inSeconds} seconds ago";
        }
        return "${diff.inMinutes} minutes ago";
      }
      return "${diff.inHours} hours ago";
    }
    return "${diff.inDays} days ago";
  }
}
