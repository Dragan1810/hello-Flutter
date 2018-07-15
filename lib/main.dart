import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

final ThemeData iOSTheme = new ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.grey,
  primaryColorBrightness: Brightness.dark,
);

final ThemeData androidTheme = new ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.green,
);

const String defaultUserName = "John Doe";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat Application",
      theme: defaultTargetPlatform == TargetPlatform.iOS
        ? iOSTheme : androidTheme,
      home: Chat(),
    );
  }
}

class Chat extends StatefulWidget {
  @override
  State createState() => ChatWindow();
}

class ChatWindow extends State<Chat> with TickerProviderStateMixin {
  final List<Msg> _messages = <Msg>[];
  final TextEditingController _textController = TextEditingController();
  bool _isWritting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Application"),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 6.0,
      ),
      body: Column(children: <Widget>[
        Flexible(
          child: ListView.builder(
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
              reverse: true,
              padding: EdgeInsets.all(6.0),
          )
        ),
        Divider(height: 1.0,),
        Container(
          child: _buildComposer(),
          decoration: BoxDecoration(color: Theme.of(context).cardColor)
        )
      ]),
    );
  }
  Widget _buildComposer() {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 9.0),
          child: Row(
            children: <Widget>[
              Flexible(child: TextField(
                controller: _textController,
                onChanged: (String txt) {
                  setState(() {
                    _isWritting = txt.length > 0;
                  });
                },
                onSubmitted: _submitMsg,
                decoration: InputDecoration.collapsed(hintText: "Enter some text to send a message!"),
              )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                  ? CupertinoButton(
                    child: Text("Submit"),
                    onPressed: _isWritting ? () => _submitMsg(_textController.text)
                        : null
                )
                    : IconButton(
                    icon: Icon(Icons.message),
                    onPressed: _isWritting
                      ? () => _submitMsg(_textController.text)
                        : null,
                )
              )
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
          ? BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.brown[200])
            )
          ): null
        )
    );
  }

  void _submitMsg(String txt) {
    _textController.clear();
    setState(() {
      _isWritting = false;
    });
    Msg msg = new Msg(
      txt: txt,
      animationController: AnimationController(
          vsync: this,
          duration: Duration(microseconds: 800)
      ),
    );
    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();

    @override
    void dispose() {
      for (Msg msg in _messages) {
        msg.animationController.dispose();
      }
      super.dispose();
    }
  }

}

class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController});
  final String txt;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController,
            curve: Curves.bounceOut,
        ),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 18.0),
              child: CircleAvatar(child: Text(defaultUserName[0])),
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(defaultUserName, style: Theme.of(context).textTheme.subhead),
                    Container(
                      margin: EdgeInsets.only(top:6.0),
                      child: Text(txt),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}