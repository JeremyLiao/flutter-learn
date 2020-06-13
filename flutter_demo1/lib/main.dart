import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo1/mvvm/view/gank_view.dart';

//import 'package:flutter_module/plugins/toast.dart';
import 'common/common.dart';
import 'views/counter_page.dart';
import 'views/version_page.dart';
import 'views/app_page.dart';
import 'views/tab_page.dart';
import 'views/layout.dart';
import 'widgets/elements/form/button/flatbutton/index.dart';
import 'widgets/scroll/scrollview/demo.dart';
import 'widgets/scroll/list/demo.dart';
import 'widgets/scroll/gridview/demo.dart';
import 'demos/router/demo.dart';

///程序入口
void main() => runApp(_widgetForRoute(window.defaultRouteName));

///路由，根据不同的名称返回相应的widget
Widget _widgetForRoute(String route) {
  switch (route) {
    case 'main':
      return MainPage();
    default:
      return MainPage();
  }
}

const EventChannel EVENT_CHANNEL =
    const EventChannel('com.jeremyliao.flutter.plugins/event');

const List<String> PAGES = [
  "version_page",
  "counter_page",
  "app_page",
  "tab_page",
  "flat_button_demo",
  "scroll_view_demo",
  "list_view_demo",
  "grid_view_demo",
  "layout_demo",
  "router_demo",
  "gank_demo",
  "mvvm_demo",
];

final Map<String, WidgetBuilder> routerMap = {
  "version_page": (context) => VersionPage(),
  "counter_page": (context) => CounterPage(),
  "app_page": (context) => AppPage(),
  "tab_page": (context) => TabPage(),
  "flat_button_demo": (context) =>
      CommonTitlePage("flat button demo", FlatButtonDemo()),
  "scroll_view_demo": (context) =>
      CommonTitlePage("scroll view demo", SingleChildScrollViewDemo()),
  "list_view_demo": (context) =>
      CommonTitlePage("list view demo", ListViewDemo()),
  "grid_view_demo": (context) =>
      CommonTitlePage("grid view demo", GridViewDemo()),
  "layout_demo": (context) => CommonTitlePage("layout demo", LayoutDemo()),
  "router_demo": (context) => CommonTitlePage("router demo", RouterDemo()),
  "gank_demo": (context) => CommonTitlePage("router demo", GankMainPage()),
  "mvvm_demo": (context) => CommonTitlePage("router demo", GankMvvmMainPage()),
};

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routerMap,
      home: MainContentPage(title: 'Main Page', pages: PAGES),
    );
  }
}

class MainContentPage extends StatefulWidget {
  MainContentPage({Key key, this.title, this.pages}) : super(key: key);

  final String title;
  final List<String> pages;

  @override
  _MainContentPageState createState() => _MainContentPageState(pages);
}

class _MainContentPageState extends State<MainContentPage> {
  List<String> _pages;

  _MainContentPageState(this._pages);

  @override
  void initState() {
    super.initState();
    EVENT_CHANNEL.receiveBroadcastStream().listen(_onEvent);
  }

  void _onEvent(Object event) {
//    Toast.showToast(event.toString());
  }

  set pages(List<String> value) {
    setState(() {
      _pages = value;
    });
  }

  int _getLength() {
    if (_pages == null) {
      return 0;
    } else {
      return _pages.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _getLength(),
          itemBuilder: (context, index) {
            String page = _pages[index];
            return FlatButton(
              child: Text(page),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, page);
              },
            );
          },
        ),
      ),
    );
  }
}
