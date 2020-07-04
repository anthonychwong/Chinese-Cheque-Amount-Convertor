import 'package:ChineseChequeConvertor/convertToCNDigit.dart';
import 'package:ChineseChequeConvertor/widgets/AdBlock.dart';
import 'package:ChineseChequeConvertor/widgets/DividerTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:url_launcher/url_launcher.dart';

// change color theme to match the by me a coffee page
Map<int, Color> buyMeACoffeeGreenMap = {
  50: Color.fromRGBO(121, 214, 181, .1),
  100: Color.fromRGBO(121, 214, 181, .2),
  200: Color.fromRGBO(121, 214, 181, .3),
  300: Color.fromRGBO(121, 214, 181, .4),
  400: Color.fromRGBO(121, 214, 181, .5),
  500: Color.fromRGBO(121, 214, 181, .6),
  600: Color.fromRGBO(121, 214, 181, .7),
  700: Color.fromRGBO(121, 214, 181, .8),
  800: Color.fromRGBO(121, 214, 181, .9),
  900: Color.fromRGBO(121, 214, 181, 1),
};

MaterialColor buyMeACoffeeGreen = MaterialColor(0xFF79D6B5, buyMeACoffeeGreenMap);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '支票金額中文大寫轉換',
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
        primarySwatch: buyMeACoffeeGreen,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '支票金額中文大寫轉換'),
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

class _MyHomePageState extends State<MyHomePage> {
  String _display = "";

  var _controller = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',');

  void _convertToCNNumber(String input) {
    setState(() {
      _display = convertToCN(input);
    });
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(() => _convertToCNNumber(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '阿拉伯金額',
                ),
                controller: _controller,
                keyboardType: TextInputType.number),
            SizedBox(
              height: 10.0,
            ),
            Container(
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "橫幅廣告",
                    style: Theme.of(context).textTheme.headline4
                  )))),
            DividerTitle(title: "金額中文大寫"),
            // Text(
            //   'You have pushed the button this many times:',
            // ),
            Text(
              '$_display',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton.icon(
                icon: Icon(Icons.library_books),
                label: Text("贊助我一本書"),
                color: Theme.of(context).primaryColor,
                onPressed: () =>
                  launch("https://www.buymeacoffee.com/anthonychwong")),
            DividerTitle(title: "你可能有興趣"),
            Text(
              "",
              textScaleFactor: 0.1,
            ),
            Expanded(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        AdBlock(
                          imageURL:
                              "https://via.placeholder.com/300x200/79D6B5/000000/png",
                          description: "廣告內容",
                        ),
                        AdBlock(
                          imageURL:
                              "https://via.placeholder.com/300x200/79D6B5/000000/png",
                          description: "廣告內容",
                        ),
                        AdBlock(
                          imageURL:
                              "https://via.placeholder.com/300x200/79D6B5/000000/png",
                          description: "廣告內容",
                        ),
                        AdBlock(
                          imageURL:
                              "https://via.placeholder.com/300x200/79D6B5/000000/png",
                          description: "廣告內容",
                        ),
                      ],
                    )))
          ],
        ),
      )),
    );
  }
}
