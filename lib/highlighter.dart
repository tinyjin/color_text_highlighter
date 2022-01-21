import 'package:color_text_highlighter/highligthedclass.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:text_selection_controls/text_selection_controls.dart';

typedef OnHighlightedCallback = void Function(
    List<HighlightedList> updatedHighlightedOffsetsList);

class Highlighter extends StatefulWidget {
  final String textData;
  final List<HighlightedList>? preHighlightedTexts;
  final OnHighlightedCallback? onHighlightedCallback;
  const Highlighter(
      {Key? key,
      required this.textData,
      this.preHighlightedTexts,
      this.onHighlightedCallback})
      : super(key: key);

  @override
  _HighlighterState createState() => _HighlighterState();
}

class _HighlighterState extends State<Highlighter> {
  List<HighlightedList> offsets = [];

  @override
  void initState() {
    offsets = widget.preHighlightedTexts ?? offsets;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      HTML.toTextSpan(
        context,
        // widget.textData,
        checker(),
          linksCallback: (dynamic link) async {
          debugPrint('You clicked on  ${link.toString()}');
          
          

       
          },
        defaultTextStyle: const TextStyle(fontSize: 16),
        overrideStyle: <String, TextStyle>{
          'body': const TextStyle(fontSize: 16),
          // 'annotation' :
          //     GoogleFonts.montserrat(fontSize: 16 + dynamicFontSize.value backgroundColor: offsets.),
          'p': const TextStyle(
            fontSize: 17,
          ),
          'a': const TextStyle(wordSpacing: 5, color: Colors.yellow),
        },
      ),
      selectionControls: FlutterSelectionControls(
        horizontalPadding: 5,
        toolBarItems: [
        
        ToolBarItem(
            item: const Icon(
              Icons.circle,
              color: Color(0xffB6B725),
              size: 28,
            ),
            onItemPressed:
                (String highlightedText, int startIndex, int endIndex) {
              setState(() {
                for (int x = 0; x < offsets.length; x++) {
                  if (offsets[x].highlightedText == highlightedText) {
                    offsets.removeAt(x);
                    print(x);
                  }
                }
                
                offsets.add(HighlightedList(
                  highlightedText,
                  "B6B725",
                ));
              });
                if (widget.onHighlightedCallback != null) {
                widget.onHighlightedCallback!(offsets);
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
                for (int x = 0; x < offsets.length; x++) {
                  if (offsets[x].highlightedText == highlightedText) {
                    offsets.removeAt(x);
                    print(x);
                  }
                }
                offsets.add(HighlightedList(
                    highlightedText, "f48989",));
              });
              if (widget.onHighlightedCallback != null) {
                widget.onHighlightedCallback!(offsets);
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
                for (int x = 0; x < offsets.length; x++) {
                  if (offsets[x].highlightedText == highlightedText) {
                    offsets.removeAt(x);
                    print(x);
                  }
                }
                offsets.add(HighlightedList(
                  highlightedText,
                  "a1e0d9",
                ));
              });
                if (widget.onHighlightedCallback != null) {
                widget.onHighlightedCallback!(offsets);
              }
            }),
          ToolBarItem(
            item: const Icon(
              Icons.copy,
            
              size: 28,
            ),
            onItemPressed:
                (String highlightedText, int startIndex, int endIndex) {
              print("hello");
            }),
            
      ]),
    );
  }

  String checker() {
     String articleTextLevel1 = "";
     articleTextLevel1 = widget.textData;

    for (int x = 0; x < offsets.length; x++) {
      articleTextLevel1 = articleTextLevel1.replaceAll(
          offsets[x].highlightedText,
          "<annotation style='background-color:#${offsets[x].colour};'>${offsets[x].highlightedText}</annotation>");
      //   "<annotation style='background-color:#${offsets[x].colour};'><a href='${offsets[x].highlightedText}'>&#9998;</a>${offsets[x].highlightedText}</annotation>");
    }
     try {
      if (articleTextLevel1
          .contains(offsets.last.highlightedText + "</annotation>")) {
      } else {
        // Fluttertoast.showToast(
        //     msg: "You can't highlight already highlighted words bug",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.black87,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        // deleteNote(offsets.last.id);
      }
    } catch (e) {}
    return articleTextLevel1;


  }
}
