// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junior_test/blocs/actions/ActionsWidgetQueryBloc.dart';
import 'package:junior_test/blocs/base/bloc_provider.dart';
import 'package:junior_test/model/RootResponse.dart';
import 'package:junior_test/model/actions/PromoItem.dart';
import 'package:junior_test/model/actions/Promo.dart';
import 'package:junior_test/resources/api/RootType.dart';
import 'package:junior_test/tools/MyDimens.dart';
import 'package:junior_test/ui/actions/ActionsWidgetArguments.dart';
import 'package:junior_test/ui/base/NewBasePageState.dart';
import 'package:junior_test/tools/Tools.dart';
import './item/ActionsItemWidget.dart';

class ActionsWidget extends StatefulWidget {
  static String TAG = "ActionsWidget";

  ActionsWidget({Key key, this.page = -1, this.count = -1}) : super(key: key);

  int page;
  int count;
  @override
  _ActionsWidgetState createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends NewBasePageState<ActionsWidget> {
  ActionsWidgetQueryBloc bloc;
  int page;
  int count;

  _ActionsWidgetState() {
    bloc = ActionsWidgetQueryBloc();
  }

  @override
  Widget build(BuildContext context) {
    page = widget.page;
    count = widget.count;

    if (page == -1) {
      final ActionsWidgetArguments args =
          ModalRoute.of(context).settings.arguments;
      page = args.page;
    }
    if (count == -1) {
      final ActionsWidgetArguments args =
          ModalRoute.of(context).settings.arguments;
      page = args.page;
    }

    return BlocProvider<ActionsWidgetQueryBloc>(
        bloc: bloc, child: getBaseQueryStream(bloc.shopItemsContentStream));
  }

  @override
  Widget onSuccess(RootTypes event, RootResponse response) {
    var actionsInfo = response.serverResponse.body.promo;
    return getNetworkAppBar(null, _getBody(actionsInfo), "Акции",
        brightness: Brightness.light);
  }

  @override
  void runOnWidgetInit() {
    bloc.loadActionsWidgetContent(page, count);
  }

  Widget _getBody(Promos actionsInfo) {
    List<Widget> widgets = [];

    for (var i = 0; i < actionsInfo.list.length; i += 1) {
      widgets.add(makePromoWidget(actionsInfo.list[i]));
    }

    return ListView(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Flexible(
            flex: 10,
            child: Column(
                children: widgets.sublist(0, (widgets.length / 2).floor()))),
        Flexible(flex: 1, child: Column(children: [])),
        Flexible(
            flex: 10,
            child: Column(
                children: widgets.sublist(
                    (widgets.length / 2).floor(), widgets.length))),
      ])
    ]);
  }

  Widget makePromoWidget(PromoItem actionInfo) {
    return  
    
    InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => ActionsItemWidget(actionId: actionInfo.id,) ));
      },
      child: Container(
      padding: EdgeInsets.all(40.0),
      child: Column(
        children: [
          Center(
              child: Text(actionInfo.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
                  ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.darken),
              image: new NetworkImage(Tools.getImagePath(actionInfo.imgFull)),
              fit: BoxFit.fitHeight)),
    ));
  }
}
