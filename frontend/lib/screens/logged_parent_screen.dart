import 'package:flutter/material.dart';
import 'package:kidromeda/screens/my_children_page.dart';
import 'package:kidromeda/screens/my_profile_page.dart';

class LoggedParentScreen extends StatefulWidget {
  static const routeName = '/logged_home';
  final int startIndex;

  LoggedParentScreen({this.startIndex = 0, Key key}) : super(key: key);

  @override
  _LoggedHomeScreenState createState() => _LoggedHomeScreenState();
}

class _LoggedHomeScreenState extends State<LoggedParentScreen> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static List<String> _widgetTitles = <String>[
    'My Children',
    'My Profile',
  ];
  static List<Widget> _widgetOptions = <Widget>[
    MyChildrenPage(),
    MyProfilePage()
  ];

  static List<Widget Function(BuildContext)> _appBarActions = [
    (BuildContext context) {
      return IconButton(
          icon: Icon(Icons.add),
          onPressed: () => Navigator.pushReplacementNamed(
                context,
                '/add_child',
      ));
    },
    (BuildContext context) {
      return IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () => Navigator.pushReplacementNamed(
                context,
                '/',
      ));
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pageList = List<Widget>();

  @override
  void initState() {
    _selectedIndex = widget.startIndex;
    pageList.add(_widgetOptions[0]);
    pageList.add(_widgetOptions[1]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_widgetTitles[_selectedIndex]),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          SizedBox.shrink(),
          _appBarActions[_selectedIndex](context),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).accentColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.child_care_outlined),
            label: 'My Children',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'My Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
