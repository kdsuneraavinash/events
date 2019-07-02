import 'package:events/components/components.dart';
import 'package:events/logic/theme.dart';
import 'package:events/ui/notification_page/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:theme_provider/theme_provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          _drawerHeaderWidget(context: context),
          Expanded(
              child: ScrollConfiguration(
            behavior: NoAnimationScrollBehaviour(),
            child: ListView(
              children: <Widget>[
                _drawerListItemWidget(
                  context: context,
                  icon: FontAwesomeIcons.bell,
                  title: "Notifications",
                  subtitle: "View Notifications",
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ThemeConsumer(
                                child: NotificationPage(),
                              ),
                        ));
                  },
                ),
                _drawerListItemWidget(
                  context: context,
                  icon: FontAwesomeIcons.checkCircle,
                  title: "Add Subscriptions",
                  subtitle: "Add subscriptions for categories",
                  onPressed: () {},
                ),
                _drawerListItemWidget(
                  context: context,
                  icon: FontAwesomeIcons.cogs,
                  title: "Settings",
                  subtitle: "Customize the app",
                  onPressed: () {},
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _drawerListItemWidget(
      {BuildContext context,
      IconData icon,
      String title,
      String subtitle,
      VoidCallback onPressed}) {
    return ListTile(
      leading: Icon(
        icon,
        color: ThemeProvider.optionsOf<ThemeOptions>(context).iconColor,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onPressed,
    );
  }

  Widget _drawerHeaderWidget({BuildContext context}) {
    return UserAccountsDrawerHeader(
      accountEmail: Text("johnDoe@alljohns.com"),
      accountName: Text("John Doe"),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        image: DecorationImage(
            image: CachedNetworkImageProvider(
                "http://www.deltaeventsllp.com/d04u/admin/clients/events.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor.withAlpha(0xcc),
                BlendMode.srcATop)),
      ),
      currentAccountPicture: CircleAvatar(child: Icon(FontAwesomeIcons.user)),
    );
  }
}
