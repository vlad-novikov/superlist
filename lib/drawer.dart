// common side menu
import 'package:flutter/material.dart';
import 'package:google_sheets_app/main.dart';
import 'package:google_sheets_app/tech_screen.dart';
import 'package:google_sheets_app/feedback_list.dart';

class DefaultDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Чек-листы',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.build),
            title: Text('Чек Техника'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TechnicianScreen(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(Icons.supervisor_account),
            title: Text('Чек Супера'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SupervisorScreen(),
                  ));
            },

          ),
          ListTile(
            leading: Icon(Icons.view_list),
            title: Text('Просмотр чеков'),

            onTap: () {
              // change app state...

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackListScreen(),
                  ));
            },

          ),
        ],
      ),
    );
  }
}