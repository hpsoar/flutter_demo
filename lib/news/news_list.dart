
import 'package:flutter/material.dart';
import '../flutter_utils/bridge/bridge.dart';
import '../flutter_utils/widgets/list/list_utils.dart';
import '../flutter_utils/widgets/refresh/refresh_indicator.dart';
import '../flutter_utils/widgets/refresh/load_more.dart';
import '../common/load_more.dart';
import 'news_item.dart';
import '../flutter_utils/widgets/common/util_mixin.dart';

class NewsListPage extends StatefulWidget with UIHelper {
  NewsListPage({Key key}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  CYBridge native;

  final GlobalKey<PullToRefreshState> _refreshIndicatorKey =
    new GlobalKey<PullToRefreshState>();

  ListModel model = new ListModel();

  LoadMoreController loadMore;

  @override
  void initState() {
    super.initState();

    loadMore = new SimpleLoadMoreController(() {
      load(false);
    });

    // load(true);

    WidgetsBinding.instance
      .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  @override
  void dispose() {
    loadMore.dispose();
    super.dispose();
  }

  Future<void> load(bool isRefresh) async{
    if (model.isLoading) return null;

    setState(() {
      model.isLoading = true;
      loadMore.isLoading = !isRefresh;
    });


    for (var i = 0; i < 20; ++i) {
      model.add(new NewsItem());
    }

    // return native.get('https://api.chunyuyisheng.com/community/v2/channel/detail/', null, (Map r, String error) {
    //   if (isRefresh) {
    //     model.clear();
    //   }

    //   for (var i = 0; i < 20; ++i) {
    //     model.add(new NewsItem());
    //   }

    //   setState(() {
    //     model.isLoading = false;
    //     loadMore.isLoading = false;
    //   });
    // });
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
                key: _refreshIndicatorKey,
                child: model.build(controller: loadMore),
                onRefresh: _refresh,
              )
            ) 
          ],
      ),
    );
  }
}