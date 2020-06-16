import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Copyong Toolkit'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          MainDrawerListTile(iconData: Icons.home, title: 'Home Page', routeName: '/'),
          MainDrawerListTile(iconData: Icons.location_on, title: 'Geo Location', routeName: '/geoLocation'),
          MainDrawerListTile(iconData: Icons.store, title: 'Shared Preference', routeName: '/sharedPreference'),
          MainDrawerListTile(iconData: Icons.format_paint, title: 'Demo Signature', routeName: '/demoSignature'),
          MainDrawerListTile(iconData: Icons.perm_device_information, title: 'Device Info', routeName: '/deviceInfo'),
        ],
      ),
    );
  }
}

class MainDrawerListTile extends StatelessWidget {

  IconData iconData;
  String title;
  String routeName;

  MainDrawerListTile({@required this.iconData, @required this.title, @required this.routeName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}

