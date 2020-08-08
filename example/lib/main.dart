import 'package:multi_select_item/multi_select_item.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Multi Select View Item Example',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List mainList = new List();
  MultiSelectController controller = new MultiSelectController();

  @override
  void initState() {
    super.initState();

    mainList.add({"key": "1"});
    mainList.add({"key": "2"});
    mainList.add({"key": "3"});
    mainList.add({"key": "4"});

    controller.disableEditingWhenNoneSelected = true;
    controller.set(mainList.length);
  }

  void add() {
    mainList.add({"key": mainList.length + 1});

    setState(() {
      controller.set(mainList.length);
    });
  }

  void delete() {
    var list = controller.selectedIndexes;
    list.sort((b, a) =>
        a.compareTo(b)); //reoder from biggest number, so it wont error
    list.forEach((element) {
      mainList.removeAt(element);
    });

    setState(() {
      controller.set(mainList.length);
    });
  }

  void selectAll() {
    setState(() {
      controller.toggleAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //block app from quitting when selecting
        var before = !controller.isSelecting;
        setState(() {
          controller.deselectAll();
        });
        return before;
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Selected ${controller.selectedIndexes.length}  ' +
              controller.selectedIndexes.toString()),
          actions: (controller.isSelecting)
              ? <Widget>[
                  IconButton(
                    icon: Icon(Icons.select_all),
                    onPressed: selectAll,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: delete,
                  )
                ]
              : <Widget>[],
        ),
        body: ListView.builder(
          itemCount: mainList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: MultiSelectItem(
                isSelecting: controller.isSelecting,
                onSelected: () {
                  setState(() {
                    controller.toggle(index);
                  });
                },
                child: Container(
                  child: ListTile(
                    title: new Text("Title ${mainList[index]['key']}"),
                    subtitle: new Text("Description ${mainList[index]['key']}"),
                  ),
                  decoration: controller.isSelected(index)
                      ? new BoxDecoration(color: Colors.grey[300])
                      : new BoxDecoration(),
                ),
              ),
            );
          },
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: add,
          tooltip: 'Increment',
          child: new Icon(Icons.add),
        ),
      ),
    );
  }
}
