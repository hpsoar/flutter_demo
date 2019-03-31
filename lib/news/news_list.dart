
import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

import 'news_item.dart';

class NewsListPage extends StatefulWidget with UIHelper {
  NewsListPage({Key key}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final bridge =HBBridge();

  ListModel model;

  LoadMoreController loadMore;

  RefreshController refreshController;

  PagedLoader loader =FakePagedLoader<List<NewsItem>>((bool isRefresh, int page){
    List<NewsItem> list = []; 

    if (page > 5) return list;

    for (var i = 0; i < 20; ++i) {
      list.add(new NewsItem());
    } 
    return list;
  });

  @override
  void initState() {
    super.initState();

    bridge.updatePage(title: "新闻");

    loadMore = SimpleLoadMoreController(() {
      load(false);
    });

    model = ListModel(loadMoreController: loadMore);

    refreshController =RefreshController(RefreshHeader());

    refreshController.refresh();
  }

  @override
  void dispose() {
    loadMore.dispose();
    super.dispose();
  }

  Future<void> load(bool isRefresh) async{

    // return native.get('https://api.chunyuyisheng.com/community/v2/channel/detail/', null, (Map r, String error) {
    //   if (isRefresh) {
    //     model.clear();
    //   }

    Future f = loader.load(isRefresh: isRefresh);

    return f.then((l) {
      print("result: $l");

      if (isRefresh) {
        model.clear();
      }

      for (var i in l) {
        model.add(i);
      }

      loadMore.hasMore = (l as List).length >=loader.pageSize;
    }).catchError((e){
      print("error: $e");
    }).whenComplete((){
      setState(() {
      });
    });
  }

  Future<void> _refresh() async {
    return load(true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f0ee),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[ 
            new Expanded(
              child: PullToRefresh(
                key: refreshController.refreshIndicatorKey,
                child: model.build(context),
                onRefresh: _refresh,
              )
            ) 
          ],
      ),
    );
  }
}