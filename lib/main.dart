import 'package:flutter/material.dart';
import 'package:hello_flutter/model/model.dart';
import 'package:hello_flutter/screens/HomeScreen.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const ROOT_URL = "https://api.themoviedb.org/3";
const API_KEY = "api_key=d77e299445f92f06250fe4596c41fde7";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sirmium-Turist",
      home: HomeScreen()
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  ListState createState() => ListState();
}

class ListState extends State<ListPage> {
  List<Movie> movies = List();
  bool hasLoaded = false;

  final PublishSubject subject = PublishSubject<String>();

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  void searchMovies(query) {
    resetMovies();
    if (query.isEmpty) {
      setState(() {
        hasLoaded = true;
      });
    }
    setState(() => hasLoaded = false);
    http.get('$ROOT_URL/search/movie?$API_KEY&query=$query')
        .then((res) => res.body)
        .then(json.decode)
        .then((map) => map["results"])
        .then((movies) => movies.forEach(addMovie))
        .then((e) {
          setState(() {
            hasLoaded = true;
          });
    });
  }

  void addMovie(item) {
    setState(() {
      movies.add(Movie.fromJson(item));
    });
    print('${movies.map((m) => m.title)}');
  }

  void onError(dynamic d) {
    setState(() {
      hasLoaded = true;
    });
  }

  void resetMovies() {
    setState(() => movies.clear());
  }

  @override
  void initState() {
    super.initState();
    subject.stream.debounce(Duration(milliseconds: 400)).listen(searchMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Searcher'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (String string) => (subject.add(string))
            ),
            hasLoaded ? Container(): CircularProgressIndicator(),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: movies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new MovieView(movies[index]);
    },
        ),
            )
          ],
      ),
    ),
    );
  }
}

class MovieView extends StatefulWidget {
  MovieView(this.movie);
  final Movie movie;

  @override
  MovieViewState createState() => MovieViewState();
}

class MovieViewState extends State<MovieView> {
  Movie movieState;

  @override
  void initState() {
    super.initState();
    movieState = widget.movie;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200.0,
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            movieState.posterPath != null ?
                Hero(
                  child: Image.network("https://image.tmdb.org/t/p/w92${movieState.posterPath}"),
                  tag: movieState.id,
                ) : Container(),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      movieState.title,
                      maxLines: 10,
        ),
    ),
    ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: movieState.favored
                        ? Icon(Icons.star)
                        : Icon(Icons.star_border),
                        color: Colors.white,
                        onPressed: () {},
                    ),
                  ),
                  
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                        icon: Icon(Icons.arrow_downward),
                        color: Colors.white,
                        onPressed: () {}
                    ),
    ),
    ],
    ),
            ),
    ],
    ),
    ),
    );
  }
}





/*
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

final ThemeData iOSTheme = ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.grey,
  primaryColorBrightness: Brightness.dark,
);

final ThemeData androidTheme = ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.green,
);

const String defaultUserName = "John Doe";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App",
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.forward)
          )
        ],
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
 */

