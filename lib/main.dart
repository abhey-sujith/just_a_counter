import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_a_counter/card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        canvasColor: Colors.white12,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Simple Counter Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final titleController = TextEditingController();
  final countController = TextEditingController();
  final List<CounterDetails> countDetails=[
    CounterDetails(id:DateTime.now().toString(),title: 'first counter',count: 0,),
    CounterDetails(id:DateTime.now().toString(),title: 'second counter',count: 0,),
    //CounterDetails(id:DateTime.now().toString(),title: 'third counter',count: 0,),

  ];

  void _addNewCounter(String ti,int co){

    if (ti==null || co<0){
      return;
    }
    final newcx=CounterDetails(
      title: ti,
      count: co,
      id: DateTime.now().toString(),
    );
    setState(() {
      countDetails.add(newcx);
    });

    Navigator.of(context).pop();
  }


  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  // onChanged: (val) {
                  //   titleInput = val;
                  // },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Count'),
                  controller: countController,
                  keyboardType: TextInputType.number,
                  // onChanged: (val) => amountInput = val,
                ),
                FlatButton(
                  child: Text('Add Transaction'),
                  textColor: Colors.purple,
                  onPressed: () =>_addNewCounter(titleController.text,int.parse(countController.text)),
                ),
              ],
            ),
          ),
        ),
      );
    },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black54,
      ),
      body:
      SingleChildScrollView(
        child:
        Column(
          children: countDetails.map((co) {
            return Dismissible(
              key: ValueKey(co.id),
              background: Container(
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 40,
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20,),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  countDetails.removeWhere((item) => item.id == co.id);
                });

              },
              child: Container(
                margin: EdgeInsets.all(5),
                height: 85,
                width: double.infinity,
                decoration: BoxDecoration(
                  //border: Border.all(),
                  color: Colors.white30,
                  gradient: LinearGradient(
                    colors: [Colors.white30, Colors.white10],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children:  <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      color: Colors.white30,
                      iconSize: 50.0,
                      onPressed: () {
                        setState(() {
                          co.count--;
                        });
                      },
                      //semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Text(
                            co.title,
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,),
                          ),
                          Text(
                            co.count.toString(),
                            style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white,),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      color: Colors.white30,
                      iconSize: 50.0,
                      onPressed: () {
                        setState(() {
                          co.count++;
                        },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>_startAddNewTransaction(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.white30,
      ),
    );
  }
}
