import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/extensions/theme/theme_extension.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class CreateNotes extends HookWidget {
  const CreateNotes({super.key, required this.onAddnotes});
  final Function(String tittle, String body) onAddnotes;

  @override
  Widget build(BuildContext context) {
    final titlecontroller = useTextEditingController();
    final bodycontroller = useTextEditingController();
    final themedata = Theme.of(context).extension<CustomTheme>()!;
    return Scaffold(
        backgroundColor: themedata.primary,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                onAddnotes(titlecontroller.text, bodycontroller.text);
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
                onPressed: () {}, icon: const Icon(Icons.menu_book_sharp)),
            TextButton(
              onPressed: () {
                onAddnotes(titlecontroller.text, bodycontroller.text);
                Navigator.pop(context);
              },
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 20),
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
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
