import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thinkbitflutter/core/widgets/roundedbuttons.dart';
import 'package:thinkbitflutter/features/highlight/highlighted_offset.dart';

import 'package:thinkbitflutter/features/highlight/custom_text_selection.dart'
    as CTS;
import 'package:thinkbitflutter/features/notes/notes.dart';

typedef OnHighlightedCallback = void Function(
    List<HighlightedOffset> updatedHighlightedOffsetsList);

class SelectableHighlighterText extends StatefulWidget {
  final String text;
  final TextStyle? unHighlightedStyle;
  final TextStyle? highlightedStyle;
  final ToolbarOptions? toolbarOptions;
  final List<HighlightedOffset>? preHighlightedTexts;
  final OnHighlightedCallback? onHighlightedCallback;
  final TextSelectionControls? selectionControls;
  final Color? bgColor;

  SelectableHighlighterText(
      {Key? key,
      required this.text,
      this.toolbarOptions,
      this.unHighlightedStyle,
      this.highlightedStyle,
      this.preHighlightedTexts,
      this.selectionControls,
      this.bgColor,
      this.onHighlightedCallback})
      : super(key: key);

  @override
  _SelectableHighlighterTextState createState() =>
      _SelectableHighlighterTextState();
}

class _SelectableHighlighterTextState extends State<SelectableHighlighterText> {
  int tempBaseOffset = 0;
  int tempExtentOffset = 0;
  List<HighlightedOffset> offsets = [];

  // List<Color> colour = [Colors.blue, Colors.red, Colors.green];

  late TextStyle unHighlightedTextStyle;
  late TextStyle highlightedTextStyle;

  @override
  void initState() {
    offsets = widget.preHighlightedTexts ?? offsets;
    unHighlightedTextStyle = widget.unHighlightedStyle ??
        TextStyle(color: Colors.black, fontSize: 16);
    // for (int x = 1; x <= colour.length; x++) {
    //   highlightedTextStyle = widget.highlightedStyle ??
    //       TextStyle(color: colour[x - 1], fontSize: 16);
    // }
    highlightedTextStyle = widget.highlightedStyle ??
        TextStyle(backgroundColor: Colors.blue, fontSize: 16);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        children: textSpanList(),
      ),
      onSelectionChanged: (value, reason) {
        tempBaseOffset = min(value.baseOffset, value.extentOffset);
        tempExtentOffset = max(value.baseOffset, value.extentOffset);
      },
      toolbarOptions: widget.toolbarOptions,
      selectionControls:

          // FlutterSelectionControls(toolBarItems: [
          //   ToolBarItem(
          //       item: Text(
          //         'Highlight',
          //         style: GoogleFonts.montserrat(fontSize: 20, color: Colors.white),
          //       ),
          //       onItemPressed:
          //           (String highlightedText, int startIndex, int endIndex) {
          //         setState(() {
          //           offsets.add(HighlightedOffset(tempBaseOffset, tempExtentOffset,
          //               widget.text.substring(tempBaseOffset, tempExtentOffset)));
          //           minimize(offsets);
          //         });
          //         if (widget.onHighlightedCallback != null) {
          //           widget.onHighlightedCallback!(offsets);
          //         }

          //         // _showMe(highlightedText);
          //       }
          //       ),
          // ]),

          CTS.CupertinoTextSelectionControls(onHighlight: () {
        showModalBottomSheet(
            elevation: 3,
            backgroundColor: Color(0xff2D2D2D),
            context: context,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: RoundedButtton(
                                btnText: "Copy",
                                color: Colors.grey.shade700,
                                textColor: Colors.white,
                                onPressed: () {
                                  // print(widget.text.toString().substring(
                                  //     tempBaseOffset, tempExtentOffset));

                                  // setState(() {
                                  //   offsets.add(HighlightedOffset(
                                  //       tempBaseOffset,
                                  //       tempExtentOffset,
                                  //       widget.text.toString().substring(
                                  //           tempBaseOffset, tempExtentOffset)));
                                  //   minimize(offsets);
                                  // });
                                  // if (widget.onHighlightedCallback != null) {
                                  //   widget.onHighlightedCallback!(offsets);
                                  // }
                                },
                                width: 80,
                              ),
                            ),
                            Flexible(
                              child: RoundedButtton(
                                btnText: "Note",
                                color: Colors.grey.shade700,
                                textColor: Colors.white,
                                onPressed: () {
                                  print(widget.text.toString().substring(
                                      tempBaseOffset, tempExtentOffset));

                                  // Navigator.of(context, rootNavigator: true)
                                  //     .push(MaterialPageRoute(
                                  //         builder: (context) => NoteScreen(highlightedText: widget.text
                                  //                   .toString()
                                  //                   .substring(tempBaseOffset,
                                  //                       tempExtentOffset),)));
                                },
                                width: 80,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: RoundedButtton(
                                  btnText: "Remove Highlight",
                                  color: Colors.grey.shade700,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      for (int x = 0; x < offsets.length; x++) {
                                        // print(offsets[x].highlightedText);

                                        if (offsets[x].highlightedText ==
                                                widget.text
                                                    .toString()
                                                    .substring(tempBaseOffset,
                                                        tempExtentOffset) &&
                                            offsets[x].start ==
                                                tempBaseOffset &&
                                            offsets[x].end ==
                                                tempExtentOffset) {
                                          offsets.removeAt(x);
                                          print(x.toString() +
                                              widget.text.toString().substring(
                                                  tempBaseOffset,
                                                  tempExtentOffset));
                                        }
                                      }
                                    });
                                    if (widget.onHighlightedCallback != null) {
                                      widget.onHighlightedCallback!(offsets);
                                    }
                                    Navigator.pop(context);
                                  },
                                  width: 140),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ColorButton(
                            onTap: () {
                              setState(() {
                                int indexChecker = 0;
                                for (int x = 0; x < offsets.length; x++) {
                                  // print(offsets[x].highlightedText);

                                  if (offsets[x].highlightedText ==
                                          widget.text.toString().substring(
                                              tempBaseOffset,
                                              tempExtentOffset) &&
                                      offsets[x].start == tempBaseOffset &&
                                      offsets[x].end == tempExtentOffset) {
                                    indexChecker = x;
                                  }
                                }
                                try {
                                  if (offsets[indexChecker].highlightedText ==
                                          widget.text.toString().substring(
                                              tempBaseOffset,
                                              tempExtentOffset) &&
                                      offsets[indexChecker].start ==
                                          tempBaseOffset &&
                                      offsets[indexChecker].end ==
                                          tempExtentOffset) {
                                    offsets.removeAt(indexChecker);
                                    offsets.add(
                                      HighlightedOffset(
                                          tempBaseOffset,
                                          tempExtentOffset,
                                          widget.text.toString().substring(
                                              tempBaseOffset, tempExtentOffset),
                                          Color(0xffF48989)),
                                    );
                                  } else if (offsets[indexChecker].start >=
                                          tempBaseOffset ||
                                      offsets[indexChecker].end >=
                                          tempExtentOffset) {
                                    offsets.add(
                                      HighlightedOffset(
                                          tempBaseOffset,
                                          tempExtentOffset,
                                          widget.text.toString().substring(
                                              tempBaseOffset, tempExtentOffset),
                                          Color(0xffF48989)),
                                    );
                                    print("Else IF 0xffB6B725");
                                  } else {
                                    offsets.add(
                                      HighlightedOffset(
                                          tempBaseOffset,
                                          tempExtentOffset,
                                          widget.text.toString().substring(
                                              tempBaseOffset, tempExtentOffset),
                                          Color(0xffF48989)),
                                    );
                                  }
                                } catch (e) {
                                  offsets.add(
                                    HighlightedOffset(
                                        tempBaseOffset,
                                        tempExtentOffset,
                                        widget.text.toString().substring(
                                            tempBaseOffset, tempExtentOffset),
                                        Color(0xffF48989)),
                                  );
                                }

                                minimize(offsets);
                              });
                              if (widget.onHighlightedCallback != null) {
                                widget.onHighlightedCallback!(offsets);
                              }
                              Navigator.pop(context);
                            },
                            colorBtn: Color(0xffF48989),
                          ),
                          SizedBox(width: 15),
                          ColorButton(
                            onTap: () {
                              setState(() {
                                int indexChecker = 0;
                                for (int x = 0; x < offsets.length; x++) {
                                  // print(offsets[x].highlightedText);

                                  if (offsets[x].highlightedText ==
                                          widget.text.toString().substring(
                                              tempBaseOffset,
                                              tempExtentOffset) &&
                                      offsets[x].start == tempBaseOffset &&
                                      offsets[x].end == tempExtentOffset) {
                                    indexChecker = x;
                                  }
                                }
                                try {
                                  if (offsets[indexChecker].highlightedText ==
                                          widget.text.toString().substring(
                                              tempBaseOffset,
                                              tempExtentOffset) &&
                                      offsets[indexChecker].start ==
                                          tempBaseOffset &&
                                      offsets[indexChecker].end ==
                                          tempExtentOffset) {
                                    offsets.removeAt(indexChecker);
                                    offsets.add(
                                      HighlightedOffset(
                                          tempBaseOffset,
                                          tempExtentOffset,
                                          widget.text.toString().substring(
                                              tempBaseOffset, tempExtentOffset),
                                          Color(0xff96D5CE)),
                                    );
                                  } else {
                                    offsets.add(
                                      HighlightedOffset(
                                          tempBaseOffset,
                                          tempExtentOffset,
                                          widget.text.toString().substring(
                                              tempBaseOffset, tempExtentOffset),
                                          Color(0xff96D5CE)),
                                    );
                                  }
                                } catch (e) {
                                  offsets.add(
                                    HighlightedOffset(
                                        tempBaseOffset,
                                        tempExtentOffset,
                                        widget.text.toString().substring(
                                            tempBaseOffset, tempExtentOffset),
                                        Color(0xff96D5CE)),
                                  );
                                }

                                minimize(offsets);
                              });
                              if (widget.onHighlightedCallback != null) {
                                widget.onHighlightedCallback!(offsets);
                              }
                              Navigator.pop(context);
                            },
                            colorBtn: Color(0xff96D5CE),
                          ),
                          SizedBox(width: 15),
                          ColorButton(
                            onTap: () {
                              setState(() {
                                int indexChecker = 0;
                                for (int x = 0; x < offsets.length; x++) {
                                  // print(offsets[x].highlightedText);

                                  if (offsets[x].highlightedText ==
                                          widget.text.toString().substring(
                                              tempBaseOffset,
                                              tempExtentOffset) &&
                                      offsets[x].start == tempBaseOffset &&
                                      offsets[x].end == tempExtentOffset) {
                                    indexChecker = x;
                                  }
                                }
                                try {
                                  if (offsets[indexChecker].highlightedText ==
                                          widget.text.toString().substring(
                                              tempBaseOffset,
                                              tempExtentOffset) &&
                                      offsets[indexChecker].start ==
                                          tempBaseOffset &&
                                      offsets[indexChecker].end ==
                                          tempExtentOffset) {
                                    offsets.removeAt(indexChecker);
                                    offsets.add(
                                      HighlightedOffset(
                                          tempBaseOffset,
                                          tempExtentOffset,
                                          widget.text.toString().substring(
                                              tempBaseOffset, tempExtentOffset),
                                          Color(0xffAED477)),
                                    );
                                  } else {
                                    offsets.add(
                                      HighlightedOffset(
                                          tempBaseOffset,
                                          tempExtentOffset,
                                          widget.text.toString().substring(
                                              tempBaseOffset, tempExtentOffset),
                                          Color(0xffAED477)),
                                    );
                                  }
                                } catch (e) {
                                  offsets.add(
                                    HighlightedOffset(
                                        tempBaseOffset,
                                        tempExtentOffset,
                                        widget.text.toString().substring(
                                            tempBaseOffset, tempExtentOffset),
                                        Color(0xffAED477)),
                                  );
                                }

                                minimize(offsets);
                              });
                              if (widget.onHighlightedCallback != null) {
                                widget.onHighlightedCallback!(offsets);
                              }
                              Navigator.pop(context);
                            },
                            colorBtn: Color(0xffAED477),
                          ),
                          SizedBox(width: 15),
                          ColorButton(
                            onTap: () {
                              print("color 5");
                              setState(() {
                                int indexChecker = 0;
                                for (int x = 0; x < offsets.length; x++) {
                                  // print(offsets[x].highlightedText);

                                  if (offsets[x].highlightedText ==
                                          widget.text.toString().substring(
                                              tempBaseOffset,
                                              tempExtentOffset) &&
                                      offsets[x].start == tempBaseOffset &&
                                      offsets[x].end == tempExtentOffset) {
                                    indexChecker = x;
                                  }
                                }
                                try {
                                  if (offsets[indexChecker].highlightedText ==
                                          widget.text.toString().substring(
                                              tempBaseOffset,
                                              tempExtentOffset) &&
                                      offsets[indexChecker].start ==
                                          tempBaseOffset &&
                                      offsets[indexChecker].end ==
                                          tempExtentOffset) {
                                    offsets.removeAt(indexChecker);
                                    offsets.add(
                                      HighlightedOffset(
                                          tempBaseOffset,
                                          tempExtentOffset,
                                          widget.text.toString().substring(
                                              tempBaseOffset, tempExtentOffset),
                                          Color(0xffB6B725)),
                                    );
                                    print("IF 0xffB6B725");
                                  } else {
                                    print("Else 0xffB6B725");

                                    offsets.add(
                                      HighlightedOffset(
                                          tempBaseOffset,
                                          tempExtentOffset,
                                          widget.text.toString().substring(
                                              tempBaseOffset, tempExtentOffset),
                                          Color(0xffB6B725)),
                                    );
                                  }
                                } catch (e) {
                                  offsets.add(
                                    HighlightedOffset(
                                        tempBaseOffset,
                                        tempExtentOffset,
                                        widget.text.toString().substring(
                                            tempBaseOffset, tempExtentOffset),
                                        Color(0xffB6B725)),
                                  );
                                }

                                // offsets.add(
                                //   HighlightedOffset(
                                //       tempBaseOffset,
                                //       tempExtentOffset,
                                //       widget.text.toString().substring(
                                //           tempBaseOffset, tempExtentOffset),
                                //       Color(0xffB6B725)),
                                // );
                                minimize(offsets);
                              });
                              if (widget.onHighlightedCallback != null) {
                                widget.onHighlightedCallback!(offsets);
                              }
                              Navigator.pop(context);
                            },
                            colorBtn: Color(0xffB6B725),
                          ),
                        ],
                      ),
                    )
                    // Center(
                    //   child: Text(
                    //     'Thank you for subscribing!',
                    //     style: GoogleFonts.montserrat(
                    //         fontSize: 24,
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.w600),
                    //   ),
                    // ),
                  ],
                ),
              );
            });

        // setState(() {
        // offsets.add(HighlightedOffset(tempBaseOffset, tempExtentOffset,
        //     widget.text.substring(tempBaseOffset, tempExtentOffset)));
        //   minimize(offsets);
        // });
        // if (widget.onHighlightedCallback != null) {
        //   widget.onHighlightedCallback!(offsets);
        // }
      }),
    );
  }

  void minimize(List<HighlightedOffset> list) {
    list.sort((a, b) => a.start.compareTo(b.start));
    List<HighlightedOffset> stack = [];
    list.forEach((i) {
      if (stack.isEmpty) {
        stack.add(i);
      } else {
        HighlightedOffset top = stack.last;
        if (top.end < i.start) {
          stack.add(i);
        } else if (top.end < i.end) {
          top.end = i.end;
          stack.removeLast();
          stack.add(top);
        }
      }
    });
    offsets = stack;
  }

  List<TextSpan> textSpanList() {
    List<TextSpan> list = [];
    if (offsets.isEmpty) {
      return [
        TextSpan(text: widget.text.toString(), style: unHighlightedTextStyle)
      ];
    }
    list.add(TextSpan(
        text: widget.text.substring(0, offsets.first.start),
        style: unHighlightedTextStyle));

    for (int i = 0; i < offsets.length; i++) {
      HighlightedOffset element = offsets[i];
      if (i == 0) {
        list.add(TextSpan(
            text: widget.text.substring(element.start, element.end),
            style:
                TextStyle(backgroundColor: offsets[i].colour, fontSize: 16)));
      } else {
        list.add(TextSpan(
          text: widget.text
              .toString()
              .substring(offsets[i - 1].end, element.start),
          style: unHighlightedTextStyle,
        ));
        list.add(TextSpan(
            text: widget.text.toString().substring(element.start, element.end),
            style:
                TextStyle(backgroundColor: offsets[i].colour, fontSize: 16)));
      }
    }

    list.add(TextSpan(
        text: widget.text
            .toString()
            .substring(offsets.last.end, widget.text.toString().length),
        style: unHighlightedTextStyle));
    return list;
  }
}

class ColorButton extends StatelessWidget {
  const ColorButton({Key? key, required this.onTap, required this.colorBtn})
      : super(key: key);
  final VoidCallback onTap;
  final Color colorBtn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.circle,
        color: colorBtn,
        size: 35,
      ),
    );
  }
}
