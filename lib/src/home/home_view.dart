import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_new_chat_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  late String viewTitle = _getTitle(0);
  static GlobalKey<HomeNewChatViewState> newChatKey = GlobalKey();

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  
  static final List<Widget> _widgetOptions = <Widget>[
    HomeNewChatView(key: newChatKey),
    const Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    const Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      viewTitle = _getTitle(_selectedIndex);
    });
  }

  String _getTitle(int index) {
    String title = '';
    switch (index) {
      case 0:
        title = AppLocalizations.of(context)!.homeViewTitle.toString();
        break;
        case 1:
        title = 'Business';
        break;
      default:
        title = AppLocalizations.of(context)!.homeViewTitle.toString();
    }
    return title;
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(viewTitle),
        actions: [
          IconButton(onPressed: (){
            newChatKey.currentState?.clearMessagesFromParent();
          }, icon: const Icon(Icons.add_comment), iconSize: 20.0,)
        ],
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Center(child: Column(children: [
                const Image(image: AssetImage("assets/images/vertex_logo.png")),
                Text(AppLocalizations.of(context)!.vertexAIText, style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),),
              Text(AppLocalizations.of(context)!.providedByGeminiAI, style: const TextStyle(
                fontSize: 15.0,
              ),),
              ],),)),
            ListTile(
              title: Text(AppLocalizations.of(context)!.homeViewTitle),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            /*
            ListTile(
              title: const Text('Business'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('School'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            */
          ],
        ),
      ),
    );
  }
}