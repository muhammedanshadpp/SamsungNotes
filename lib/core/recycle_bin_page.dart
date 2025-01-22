import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/extensions/theme/theme_extension.dart';
import 'package:flutter_application_1/core/notes_class.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class recyleopenPage extends HookWidget {
  final int index;
  final Notes recycleNotes;

  recyleopenPage({
    super.key,
    required this.index,
    required this.recycleNotes,
  });

  @override
  Widget build(BuildContext context) {
    final titlecontroller = useTextEditingController(text: recycleNotes.title);
    final bodycontroller = useTextEditingController(text: recycleNotes.body);
    final themedata = Theme.of(context).extension<CustomTheme>()!;
    return Scaffold(
        backgroundColor: themedata.primary,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                // onUpdated(index, titlecontroller.text, bodycontroller.text);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: TextFormField(
            controller: titlecontroller,
            decoration: const InputDecoration(
                hintText: "Title", border: InputBorder.none),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // onUpdated(index, titlecontroller.text, bodycontroller.text);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.edit)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            PopupMenuButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: themedata.primary,
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Full screen",
                              style: TextStyle(color: themedata.secondry),
                            ))),
                    PopupMenuItem(
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Tags",
                              style: TextStyle(color: themedata.secondry),
                            ))),
                    PopupMenuItem(
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Save as File",
                              style: TextStyle(color: themedata.secondry),
                            ))),
                    PopupMenuItem(
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Print",
                              style: TextStyle(color: themedata.secondry),
                            ))),
                    PopupMenuItem(
                        child: Text("..................................")),
                    PopupMenuItem(
                        child: Row(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.star_outline)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 130,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 100, top: 20),
                                            child: Text(
                                              "Move note to the Recycle bin?",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: themedata.secondry),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 35,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            themedata.secondry),
                                                  )),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    // moveToRecycleBin(index);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Move To Recycle Bin",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            themedata.secondry),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ))
                  ];
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(children: [
            TextFormField(
              controller: bodycontroller,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "text",
              ),
            )
          ]),
        ));
  }
}
