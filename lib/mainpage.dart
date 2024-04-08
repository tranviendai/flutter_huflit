import 'package:app_provider/app/model/category.dart';
import 'package:app_provider/app/model/user.dart';
import 'package:flutter/material.dart';
import 'app/page/defaultwidget.dart';
import 'app/page/register.dart';

class Mainpage extends StatefulWidget {
  final User user;
  const Mainpage({super.key, required this.user});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _loadWidget(int index) {
    var nameWidgets = "Home";
    switch (index) {
      case 0:
        nameWidgets = "Home";
        break;
      case 1:
        nameWidgets = "Contact";
        break;
      case 2:
        nameWidgets = "Info";
        break;
      case 3:
        {
          return  Register(user: widget.user);
        }
      default:
        nameWidgets = "None";
        break;
    }
    return DefaultWidget(title: nameWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HUFLIT Mobile"),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
           DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                 widget.user.imageUrl!.length < 5 ? SizedBox() : CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        widget.user.imageUrl!,
                  )),
                  const SizedBox(
                    height: 8,
                  ),
                  Text("${widget.user.fullName!}"),
                  Text("${widget.user.accountId!}"),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('History'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: const Text('Cart'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 2;
                setState(() {});
              },
            ),
            const Divider(
              color: Colors.black,
            ),
           widget.user.accountId == '' ? SizedBox() : ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                setState(() {});
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: _loadWidget(_selectedIndex),
    );
  }
}
