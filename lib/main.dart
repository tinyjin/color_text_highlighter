import 'package:color_text_highlighter/highlighter.dart';
import 'package:color_text_highlighter/highligthedclass.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

List<HighlightedList> offsetsCase = [];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
         debugShowCheckedModeBanner: false,
      title: 'Flutter Text HIghlighter',
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
      home: const TextHighlighter(),
    );
  }
}

class TextHighlighter extends StatefulWidget {
  const TextHighlighter({Key? key}) : super(key: key);

  @override
  _TextHighlighterState createState() => _TextHighlighterState();
}

class _TextHighlighterState extends State<TextHighlighter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF4),
      appBar: AppBar(
        title: const Text("Color Text Highlighter"),
        actions: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: ElevatedButton(
          onPressed: () {
             setState(() {
               
             });
          },
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: BorderSide(color: Colors.white54)))),
          child: const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text('Refresh List',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
          ),
        ),
           ),
        ]
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
        const  Center(
              child:  Text(
                "List of Selected Text",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )),

          offsetsCase.isEmpty ? const Padding(
            padding:  EdgeInsets.all(8.0),
            child: Text("No Data"),
          ) :

          ListView.separated(
            itemCount: offsetsCase.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 1.0,
              indent: 1.0,
              color: Colors.grey,
            ),
            itemBuilder: (BuildContext context, int index) {
                  

              return Dismissible(
                  key: UniqueKey(),
                  direction: (DismissDirection.endToStart),
                  onDismissed: (direction) {
                    setState(() {
                      offsetsCase.removeAt(index);
                    });
                  },
                  background: Container(
                    color: const Color(0xff686768),
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text('Remove',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Color(
                                int.parse("0xff${offsetsCase[index].colour}"))),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(offsetsCase[index].highlightedText),
                        ),
                      ),
                    ],
                  ));
              // return Row(
              //   children: [
              //       Container(
              //       height: 100,
              //       width: 7,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(0),
              //           color: Color(int.parse("0xff${offsetsCase[index].colour}"))),
              //     ),

              //     Flexible(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text(offsetsCase[index].highlightedText),
              //       ),
              //     ),
              //   ],
              // );
            },
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: const Text("Data"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => const TextHighlighterData(
                  )));
        },
      ),
    );
  }
}

class TextHighlighterData extends StatefulWidget {

  const TextHighlighterData({Key? key})
      : super(key: key);

  @override
  _TextHighlighterDataState createState() => _TextHighlighterDataState();
}

class _TextHighlighterDataState extends State<TextHighlighterData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF4),
      appBar: AppBar(
        title: const Text("Color Text Highlighter"),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
            onPressed: () {
           

              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
              child: Text(
            "Text",
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Highlighter(
              textData:
                  """Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance.\n The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced 
              in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.  It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).""",
              preHighlightedTexts: offsetsCase,
              onHighlightedCallback: (list) {
                setState(() {
                  offsetsCase = list;
                  print("the list is $list");
                });
              },
            ),
          )
        ],
      )),
    );
  }
}
