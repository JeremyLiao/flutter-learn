import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo1/mvvm/model/gank_model.dart';
import 'package:flutter_demo1/mvvm/vm/gank_vm.dart';
import 'package:provider/provider.dart';

class GankMvvmMainPage extends StatelessWidget {
  final _viewModel = GankViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: GankWidget(),
    );
  }
}

class GankWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<GankViewModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          child: Text('get content'),
          textColor: Colors.blue,
          onPressed: vm.getBanner,
        ),
        Expanded(
            child: ListView.builder(
          itemCount: vm.banners.length,
          itemBuilder: (context, index) {
            var banner = vm.banners[index];
            return ListTile(
              title: Text(banner.title),
              subtitle: Text(banner.url),
            );
          },
        ))
      ],
    );
  }
}

class GankMainPage extends StatefulWidget {
  GankMainPage({Key key}) : super(key: key);

  @override
  _GankMainPageState createState() => _GankMainPageState();
}

class _GankMainPageState extends State<GankMainPage> {
  String _content = '';

  void _getContent1() {
    GankModel.getBanners().doOnListen(() {
      setState(() {
        _content = '';
      });
    }).listen((event) {
      setState(() {
        _content = event.toString();
      });
    });
  }

  void _getContent() async {
    try {
      setState(() {
        _content = '';
      });
      Response response = await Dio().get("https://gank.io/api/v2/banners");
      print(response.data);
      setState(() {
        _content = response.toString();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text('get content'),
            textColor: Colors.blue,
            onPressed: _getContent,
          ),
          FlatButton(
            child: Text('get content1'),
            textColor: Colors.blue,
            onPressed: _getContent1,
          ),
          Text(_content),
        ],
      ),
    );
  }
}
