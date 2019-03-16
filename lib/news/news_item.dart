import 'package:flutter/material.dart';
import '../flutter_utils/widgets/list/list_utils.dart';
import '../flutter_utils/widgets/builder.dart';

class NewsItem extends ListItem {
  @override
  Widget build(BuildContext ctxt, int index) {
    return 
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 15, top: 5, bottom: 20, right: 15),
        child: Row(
          children:<Widget>[
          Container(
            child: UIFork().roundUrlImage('https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1548074337&di=5988fdb643cf7351459253b7857694cd&src=http://pic.58pic.com/58pic/13/98/34/78J58PIC7r3_1024.png', 60, borderColor: Colors.red).done(),
            margin: EdgeInsets.only(right: 15),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text('张小帅$index', style: TextStyle(fontSize: 18, color: Colors.red)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: Text('15910886599', style: TextStyle(fontSize: 14, color: Colors.yellow)),
                )
              ],
            ),
          ),
        ],
        ),
      );
  }
}