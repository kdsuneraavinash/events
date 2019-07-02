import 'package:events/ui/notification_page/notification.dart';
import 'package:events/views/notification.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:theme_provider/theme_provider.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notifications."),
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemBuilder: (_, index) => NotificationItem(
              notificationView: NotificationView.fromIndex(index),
            ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(FontAwesomeIcons.checkDouble),
        label: Text("Mark as read"),
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
