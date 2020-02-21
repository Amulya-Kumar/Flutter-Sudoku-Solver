import 'package:flutter/material.dart';
import 'package:sudoku_game/common/block.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/*
[0,0,0,2,6,0,7,0,1],
[6,8,0,0,7,0,0,9,0],
[1,9,0,0,0,4,5,0,0],
[8,2,0,1,0,0,0,4,0],
[0,0,4,6,0,2,9,0,0],
[0,5,0,0,0,3,0,2,8],
[0,0,9,3,0,0,0,7,4],
[0,4,0,0,5,0,0,3,6],
[7,0,3,0,1,8,0,0,0],
 */

var blockGrid = new List<List<Block>>.generate(9, (_) => new List<Block>(9));
var grid = [[5,3,0,0,7,0,0,0,0],
            [6,0,0,1,9,5,0,0,0],
            [0,9,8,0,0,0,0,6,0],
            [8,0,0,0,6,0,0,0,3],
            [4,0,0,8,0,3,0,0,1],
            [7,0,0,0,2,0,0,0,6],
            [0,6,0,0,0,0,2,8,0],
            [0,0,0,4,1,9,0,0,5],
            [0,0,0,0,8,0,0,7,9],];
  
var helpGrid = new List<List<int>>.generate(9, (_) => new List<int>(9));

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width * 0.45;

    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        Block tempBlock = new Block(
          value: helpGrid[i][j] == null ? grid[i][j] : helpGrid[i][j],
        );
        blockGrid[i][j] = tempBlock;
      }
    }

    Widget _buildPixelGridItems(BuildContext context, int index) {
      int x, y = 0;
      x = (index ~/ 9).floor();
      y = ((index % 9).toInt()).floor();
      return GridTile(
        child: blockGrid[x][y],
      );
    }

    bool possible(int x, int y, int n) {
      for (int i = 0; i < 9; i++) {
        if (grid[x][i] == n) {
          return false;
        }
      }
      for (int i = 0; i < 9; i++) {
        if (grid[i][y] == n) {
          return false;
        }
      }
      int x0 = (x / 3).floor() * 3;
      int y0 = (y / 3).floor() * 3;

      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (grid[x0 + i][y0 + j] == n) {
            return false;
          }
        }
      }
      return true;
    }

    void solve() {
      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          if (grid[i][j] == 0) {
            for (int n = 1; n < 10; n++) {
              if (possible(i, j, n)) {
                grid[i][j] = n;
                solve();
                grid[i][j] = 0;
              }
            }
            return;
          }
        }
      }
      for(int i=0; i<9; i++){
        for(int j=0; j<9; j++){
          setState(() {
            helpGrid[i][j] = grid[i][j];
          });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              solve();
            },
            child: Text("Solve Sudoku!"),
          )
        ],
      ),
      body: Center(
        child: Container(
          width: _width,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 9,
            ),
            padding: EdgeInsets.all(20.0),
            itemBuilder: _buildPixelGridItems,
            itemCount: 81,
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
