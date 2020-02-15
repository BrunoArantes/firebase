import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List novapg = [];
List fotos = [
  "https://scontent-gru2-1.xx.fbcdn.net/v/t31.0-8/s960x960/14711654_1142378712505024_7101187375260432527_o.jpg?_nc_cat=107&_nc_ohc=n3aQTaxeV5UAX-9dtwF&_nc_ht=scontent-gru2-1.xx&_nc_tp=7&oh=24bc5e632b96c8fc0e945a0cfaeb26e5&oe=5EBDE08D",
  "https://scontent-gru2-2.xx.fbcdn.net/v/t1.0-9/s960x960/70464075_3026778337349433_317051298924986368_o.jpg?_nc_cat=102&_nc_ohc=VT_AQ-HSJLAAX_jHt5R&_nc_ht=scontent-gru2-2.xx&_nc_tp=7&oh=a794d34ca803eb92f689146aa5993978&oe=5ED33580"
];

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: novapg.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(novapg[index].data['nome']),
            subtitle: Text(novapg[index].data['contato'].toString()),
            leading: Image.network(fotos[index]),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Newpage(receba: novapg[index])));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var data = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: "mathcal@hotmail.com", password: "lopinho123");

          DocumentSnapshot lopes = await Firestore.instance
              .collection('usuarios')
              .document(data.uid)
              .get();

          QuerySnapshot novepg =
              await Firestore.instance.collection('clientes').getDocuments();

          novapg = novepg.documents;
          print(novapg[0].data["nome"]);
          setState(() {});

          // FirebaseAuth.instance
          //     .signInWithEmailAndPassword(email: null, password: null);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Newpage extends StatelessWidget {
  DocumentSnapshot receba;
  Newpage({this.receba});

  @override
  Widget build(BuildContext context) {
    print(receba.data['nome']);

    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Container(
              child: Image.network(
                  "https://scontent-gru1-1.xx.fbcdn.net/v/t1.0-9/p960x960/84415717_2494324897357361_5718616051155992576_o.jpg?_nc_cat=103&_nc_ohc=QBMYj6p1-bQAX_m-nJG&_nc_ht=scontent-gru1-1.xx&_nc_tp=6&oh=ff3421fc11839a26ed70a6d0f0309aa5&oe=5EC8C6EC"),
            ),
            Text("O ${receba.data["nome"]} é namorado do Bruno")
          ],
        ));
  }
}
