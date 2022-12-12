import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:text_selection_controls/text_selection_controls.dart';

typedef OnHighlightedCallback = void Function(
    HighlightedList updatedHighlightedOffsetsList);

typedef OnTabCallback = void Function(
    String text);

class Highlighter extends StatefulWidget {
  final String textData;
  final TextStyle? textStyle;
  final List<HighlightedList> preHighlightedTexts;
  final OnHighlightedCallback? onHighlightedCallback;
  final OnTabCallback? onTabCallback;
  const Highlighter(
      {Key? key,
      required this.textData,
      this.textStyle,
      required this.preHighlightedTexts,
      this.onHighlightedCallback,
      this.onTabCallback})
      : super(key: key);

  @override
  _HighlighterState createState() => _HighlighterState();
}

class _HighlighterState extends State<Highlighter> {
  // List<HighlightedList> widget.preHighlightedTexts = [];
  String formattedText = "";

  @override
  void initState() {
    // widget.preHighlightedTexts = widget.preHighlightedTexts ?? widget.preHighlightedTexts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      HTML.toTextSpan(
        context,
        checker(),
        defaultTextStyle: widget.textStyle ?? const TextStyle(fontSize: 16),
        overrideStyle: <String, TextStyle>{
          'body': const TextStyle(fontSize: 16),
          'p': const TextStyle(
            fontSize: 17,
          ),
          'a': const TextStyle(
              wordSpacing: 5,
              color: Colors.black,
              decoration: TextDecoration.none),
        },
        tabCallback: (text) {
          bool isContained = widget.preHighlightedTexts.where((element) => element.highlightedText == text).isNotEmpty;
          if (isContained && widget.onTabCallback != null) {
            widget.onTabCallback!(text);
          }
        }
      ),
      selectionControls:
          FlutterSelectionControls(horizontalPadding: 5, toolBarItems: [
        ToolBarItem(
            item: const Icon(
              Icons.circle,
              color: Color(0xffB6B725),
              size: 28,
            ),
            onItemPressed:
                (String highlightedText, int startIndex, int endIndex) {
              setState(() {
                for (int x = 0; x < widget.preHighlightedTexts.length; x++) {
                  if (widget.preHighlightedTexts[x].highlightedText == highlightedText) {
                    widget.preHighlightedTexts.removeAt(x);
                  }
                  if (widget.preHighlightedTexts[x].highlightedText.contains(highlightedText)) {
                    Fluttertoast.showToast(
                        msg:
                            "You can't highlight already highlighted words bug",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                }
              });
              if (widget.onHighlightedCallback != null) {
                var offset = HighlightedList(
                  widget.preHighlightedTexts.length,
                  highlightedText,
                  "B6B725",
                );

                widget.onHighlightedCallback!(offset);
              }
            }),
        ToolBarItem(
            item: const Icon(
              Icons.circle,
              color: Color(0xfff48989),
              size: 28,
            ),
            onItemPressed:
                (String highlightedText, int startIndex, int endIndex) {
              setState(() {
                for (int x = 0; x < widget.preHighlightedTexts.length; x++) {
                  if (widget.preHighlightedTexts[x].highlightedText == highlightedText) {
                    widget.preHighlightedTexts.removeAt(x);
                  }
                }
              });
              if (widget.onHighlightedCallback != null) {
                var offset = HighlightedList(
                  widget.preHighlightedTexts.length,
                  highlightedText,
                  "f48989",
                );

                widget.onHighlightedCallback!(offset);
              }
            }),
        ToolBarItem(
            item: const Icon(
              Icons.circle,
              color: Color(0xffa1e0d9),
              size: 28,
            ),
            onItemPressed:
                (String highlightedText, int startIndex, int endIndex) {
              setState(() {
                for (int x = 0; x < widget.preHighlightedTexts.length; x++) {
                  if (widget.preHighlightedTexts[x].highlightedText == highlightedText) {
                    widget.preHighlightedTexts.removeAt(x);
                  }
                }
              });
              if (widget.onHighlightedCallback != null) {
                var offset = HighlightedList(
                  widget.preHighlightedTexts.length,
                  highlightedText,
                  "a1e0d9",
                );

                widget.onHighlightedCallback!(offset);
              }
            }),
        ToolBarItem(
            item: const Icon(
              Icons.copy,
              size: 28,
            ),
            onItemPressed:
                (String highlightedText, int startIndex, int endIndex) {}),
      ]),
    );
  }

  String checker() {
    String articleTextLevel1 = "";
    articleTextLevel1 = widget.textData;

    for (int x = 0; x < widget.preHighlightedTexts.length; x++) {
      articleTextLevel1 = articleTextLevel1.replaceAll(
          widget.preHighlightedTexts[x].highlightedText,
          "<annotation style='background-color:#${widget.preHighlightedTexts[x].colour};'>${widget.preHighlightedTexts[x].highlightedText}</annotation>");
    }
    return articleTextLevel1;
  }
}

class HighlightedList {
  String highlightedText;
  String colour;
  int id;
  HighlightedList(this.id, this.highlightedText, this.colour);
}
