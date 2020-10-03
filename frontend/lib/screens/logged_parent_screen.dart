import 'package:flutter/material.dart';
import 'package:kidromeda/screens/my_children_page.dart';
import 'package:kidromeda/screens/my_profile_page.dart';
import '../widgets/add_child_dialog.dart';
import '../widgets/custom_snackbar.dart';
import '../utils/string_utils.dart';

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
        onPressed: () => _displayAddKidDialog(context),
      );
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

_displayAddKidDialog(BuildContext context) async {
  final GlobalKey<FormState> _deleteFormKey = GlobalKey<FormState>();
  String _password;
  String _newPassword;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Add Kid')),
          content: Form(
            key: _deleteFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  obscureText: true,
                  validator: isPasswordCompliant,
                  onChanged: (val) => _password = val,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  validator: isPasswordCompliant,
                  onChanged: (val) => _password = val,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  validator: isPasswordCompliant,
                  onChanged: (val) => _newPassword = val,
                  decoration: InputDecoration(hintText: "Confirm Password"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text(
                'Add',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                if (_deleteFormKey.currentState.validate()) {
                  // send request
                }
              },
            ),
          ],
        );
      });
}
