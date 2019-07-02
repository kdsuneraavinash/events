import 'dart:async';

import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:event_app/state/query.dart';
import 'package:event_app/redux_store/store.dart';
import 'package:event_app/redux_store/actions.dart' as Actions;

/// Reads all documents once.
/// Fired when FirestoreStartConnection is dispatched.
Stream<dynamic> readAllDocuments(
    Stream<dynamic> actions, EpicStore<EventState> eventState) {
  return new Observable(actions)
      // Only take these type actions
      // This will be done when FirestoreStartConnection is fired
      // Then stream is initialized
      // Stream will send Actions as Firestore sends undates
      .ofType(TypeToken<Actions.FirestoreRefreshAll>())
      // Switch map will cancel operation done before and start new one
      // So only one getAllEvents will run at a time
      .switchMap(
    // This function will take the FirestoreStartConnection and start the stream
    (Actions.FirestoreRefreshAll requestAction) {
      return getAllEvents(eventState.state)
          // Send each sent update to a Action and dispatch it
          .map((querySnapshot) =>
              Actions.FirestoreDocumentsChanged(querySnapshot, DateTime.now()));
    },
  );
}

/// Starts the stream of listening to changes
Stream<dynamic> listenToChanges(
    Stream<dynamic> actions, EpicStore<EventState> eventState) {
  return Observable(actions)
      // Triggered by FirestoreListenToUpdates actions
      .ofType(TypeToken<Actions.FirestoreListenToUpdates>())
      // Switch map because we need this to stop and begin from start
      // when new FirestoreListenToUpdates Comes
      .switchMap(
    // This function will start the stream of data
    (Actions.FirestoreListenToUpdates requestAction) {
      // If detected change get changed documents and do this on each
      return getChanges(eventState.state).map(
        (QuerySnapshot data) {
          // What to do to every document change
          return Actions.FirestoreDocumentsChanged(data, DateTime.now());
        },
      );
    },
  );
}

/// Observe the stream and issue events.
Observable<QuerySnapshot> getAllEvents(EventState eventState) {
  // Get documents
  // Convert resulting QuerySnapshot to a list of events
  return Observable(
      Stream.fromFuture(getStream(eventState.searchOptions).getDocuments()));
}

/// Observe the stream and issue events when document changed
Observable<QuerySnapshot> getChanges(EventState eventState) {
  // Get stream of changing snapshots
  return Observable(getStream(eventState.searchOptions).snapshots());
}

/// Get the stream according to user seach preferences
Query getStream(QueryOptions options) {
  Query query = Firestore.instance.collection("events");
  bool isDescending = options.orderOption == QueryOptionsOrder.DESCENDING;

  switch (options.sortOption) {
    case QueryOptionsSort.START:
      query = query.orderBy("start", descending: isDescending);
      break;
    case QueryOptionsSort.END:
      query = query.orderBy("end", descending: isDescending);
      break;
    case QueryOptionsSort.NAME:
      query = query.orderBy("eventName", descending: isDescending);
      break;
  }

  if (options.limitOption == QueryOptionsLimit.LIMIT) {
    query = query.limit(options.limitOptionData);
  }

  return query;
}
