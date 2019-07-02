import 'package:events/logic/theme.dart';
import 'package:events/views/notification.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class NotificationItem extends StatelessWidget {
  final NotificationView notificationView;

  const NotificationItem({Key key, this.notificationView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          notificationView.icon,
          color: Colors.white,
          size: 20.0,
        ),
        backgroundColor: notificationView.isRead ? Colors.grey : null,
      ),
      title: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.subhead,
          children: <TextSpan>[
            _emphasizedTextWidget(context, notificationView.messageStart),
            TextSpan(
              text: notificationView.messageMiddle,
              style: TextStyle(
                color: notificationView.isRead ? Colors.grey : null,
              ),
            ),
            _emphasizedTextWidget(context, notificationView.messageEnd),
          ],
        ),
      ),
      subtitle: Text(notificationView.dateString),
    );
  }

  TextSpan _emphasizedTextWidget(BuildContext context, String text) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontWeight: FontWeight.w800,
        color: notificationView.isRead
            ? Theme.of(context).disabledColor
            : ThemeProvider.optionsOf<ThemeOptions>(context).iconColor,
      ),
    );
  }
}
