import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hello_world/actions/actions.dart';
import 'package:hello_world/models/Alarm.dart';
import 'package:hello_world/store/AppState.dart';
import 'package:hello_world/store/store.dart';
import 'package:redux/redux.dart';

void main() async {
  final store = await createStore();

  runApp(LunchingApp(store));
}

class LunchingApp extends StatelessWidget {
  final Store<AppState> store;
  LunchingApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      child: MaterialApp(
          home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StoreConnector<AppState, List<Alarm>>(
                converter: (store) => store.state.alarms,
                builder: (context, alarms) {
                  return Text(
                    alarms.length > 0 && alarms[alarms.length - 1] != null
                        ? alarms[alarms.length - 1].time
                        : '',
                    style: Theme.of(context).textTheme.display1,
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: StoreConnector<AppState, VoidCallback>(
          converter: (store) {
            return () => store.dispatch(SetAlarmAction());
          },
          builder: (context, callback) {
            return FloatingActionButton(
              onPressed: callback,
              tooltip: 'asdasdasd',
              child: Icon(Icons.add),
            );
          },
        ),
      )),
      store: store,
    );
  }
}