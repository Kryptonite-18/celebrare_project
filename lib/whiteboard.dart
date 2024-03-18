import 'package:flutter/material.dart';

class TextEditorScreen extends StatefulWidget {
  @override
  _TextEditorScreenState createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  TextEditingController _textEditingController = TextEditingController();
  double _fontSize = 20.0;
  Color _fontColor = Colors.black;
  FontWeight _fontWeight = FontWeight.normal;
  FontStyle _fontStyle = FontStyle.normal;
  Offset _position = Offset(165, 20);

  List<Offset> _positionHistory = [Offset(165, 20)];

  String text = "New Text";

  void _changeFontSize(double size) {
    setState(() {
      _fontSize = size;
    });
  }

  void _changeFontColor(Color color) {
    setState(() {
      _fontColor = color;
    });
  }

  void _changeFontWeight(FontWeight weight) {
    setState(() {
      _fontWeight = weight;
    });
  }

  void _changeFontStyle(FontStyle style) {
    setState(() {
      _fontStyle = style;
    });
  }

  bool _canUndo() => _positionHistory.length > 1; // Check if there's history

  void _undo() {
    setState(() {
      _position = _positionHistory.removeLast();
      _position = _positionHistory.last;

      // Remove last position and update current
    });
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "E d i t   T e x t",
                        style: TextStyle(fontSize: 18),
                      )),
                ),
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Enter text here...',
                  ),
                  maxLines: null,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('F o n t    S i z e '),
                DropdownButton<double>(
                  value: _fontSize,
                  onChanged: (value) {
                    setState(() {
                      _fontSize = value!;
                    });
                  },
                  items: <DropdownMenuItem<double>>[
                    DropdownMenuItem<double>(
                      value: 14.0,
                      child: Text('14'),
                    ),
                    DropdownMenuItem<double>(
                      value: 16.0,
                      child: Text('16'),
                    ),
                    DropdownMenuItem<double>(
                      value: 18.0,
                      child: Text('18'),
                    ),
                    DropdownMenuItem<double>(
                      value: 20.0,
                      child: Text('20'),
                    ),
                    DropdownMenuItem<double>(
                      value: 22.0,
                      child: Text('22'),
                    ),
                    DropdownMenuItem<double>(
                      value: 24.0,
                      child: Text('24'),
                    ),
                    DropdownMenuItem<double>(
                      value: 26.0,
                      child: Text('26'),
                    ),
                    DropdownMenuItem<double>(
                      value: 30.0,
                      child: Text('30'),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text('F o n t    C o l o r'),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildColorButton(Colors.black),
                      _buildColorButton(Colors.red),
                      _buildColorButton(Colors.blue),
                      _buildColorButton(Colors.green),
                      _buildColorButton(Colors.orange),
                      _buildColorButton(Colors.purple),
                      _buildColorButton(Colors.yellow),
                      _buildColorButton(Colors.pink),
                      _buildColorButton(Colors.teal),
                      _buildColorButton(Colors.cyan),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Text('F o n t     W e i g h t'),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildWeightButton(FontWeight.w200),
                      _buildWeightButton(FontWeight.w300),
                      _buildWeightButton(FontWeight.w400),
                      _buildWeightButton(FontWeight.w500),
                      _buildWeightButton(FontWeight.w600),
                      _buildWeightButton(FontWeight.w700),
                      _buildWeightButton(FontWeight.w800),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Text('F o n t    S t y l e'),
                Row(
                  children: [
                    _buildStyleButton(FontStyle.normal),
                    _buildStyleButton(FontStyle.italic),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_textEditingController.text.isNotEmpty) {
                            text = _textEditingController.text;
                          }
                        });
                        Navigator.of(context).pop();
                        _textEditingController.clear();
                      },
                      child: Text('Apply Changes'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _textEditingController.text = "New Text";
                        });
                        Navigator.of(context).pop();
                        _textEditingController.clear();
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildColorButton(Color color) {
    return InkWell(
      splashColor: color,
      borderRadius: BorderRadius.circular(400),
      onTap: () {
        _changeFontColor(color);
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  Widget _buildWeightButton(FontWeight weight) {
    return InkWell(
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(20),
      onTap: () => _changeFontWeight(weight),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
              color: _fontWeight == weight ? Colors.blue : Colors.grey),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          weight.toString().split('.')[1],
          style: TextStyle(fontWeight: weight),
        ),
      ),
    );
  }

  Widget _buildStyleButton(FontStyle style) {
    return InkWell(
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(20),
      onTap: () => _changeFontStyle(style),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
              color: _fontStyle == style ? Colors.blue : Colors.grey),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          style.toString().split('.')[1],
          style: TextStyle(fontStyle: style),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('W h i t e b o a r d '),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.undo),
                onPressed: _canUndo() ? _undo : null,
              ),

              Text("Undo"),
              SizedBox(
                width: 10,
              ),
              // IconButton(
              //   icon: Icon(Icons.redo),
              //   onPressed: _canRedo() ? _redo : null,
              // ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: GestureDetector(
              onTap: () {
                _openBottomSheet();
              },
              child: Draggable(
                feedback: Material(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: _fontSize,
                      color: _fontColor,
                      fontWeight: _fontWeight,
                      fontStyle: _fontStyle,
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    // Provide the text widget as child
                    text,
                    style: TextStyle(
                      fontSize: _fontSize,
                      color: _fontColor,
                      fontWeight: _fontWeight,
                      fontStyle: _fontStyle,
                    ),
                  ),
                ),
                childWhenDragging: Container(),
                onDragEnd: (details) {
                  setState(() {
                    _position = details.offset - Offset(0, 80);

                    _positionHistory
                        .add(_position); // Update position with final offset
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
