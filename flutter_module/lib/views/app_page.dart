import 'package:flutter/material.dart';

// const int ThemeColor = 0xFFC91B3A;

class AppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<AppPage> {
  int _currentIndex = 0;
  static List tabData = [
    {'text': '业界动态', 'icon': Icon(Icons.language)},
    {'text': 'WIDGET', 'icon': Icon(Icons.extension)},
    {'text': '组件收藏', 'icon': Icon(Icons.favorite)},
    {'text': '关于手册', 'icon': Icon(Icons.import_contacts)}
  ];

  List<BottomNavigationBarItem> myTabs = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(BottomNavigationBarItem(
        icon: tabData[i]['icon'],
        title: Text(
          tabData[i]['text'],
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Bottom Navigation Bar'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: myTabs,
        //高亮  被点击高亮
        currentIndex: _currentIndex,
        //修改 页面
        onTap: _onItemTapped,
        //shifting :按钮点击移动效果
        //fixed：固定
        type: BottomNavigationBarType.fixed,

        fixedColor: Color(0xFFC91B3A),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
