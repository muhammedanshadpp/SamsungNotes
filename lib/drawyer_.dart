import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/notes_class.dart';

import 'package:flutter_application_1/core/recycalebin_new.dart';

import 'package:flutter_application_1/first_page.dart';
import 'package:flutter_application_1/trash.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class DrawerPage extends HookWidget {
  final Color primarycolour;
  final Color secondarycolour;
  final ValueNotifier<List<Notes>> deletedNotesNotifier;

  DrawerPage({
    required this.primarycolour,
    required this.secondarycolour,
    required this.deletedNotesNotifier,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primarycolour,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 220, top: 25),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => hiihihi(),
                  ));
                },
                icon: Icon(
                  Icons.settings_outlined,
                  color: secondarycolour,
                )),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FirstPage(
                                  deletedNotesNotifier: deletedNotesNotifier,
                                )));
                  },
                  icon: Icon(
                    Icons.note,
                    color: secondarycolour,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "All notes",
                      style: TextStyle(color: secondarycolour, fontSize: 20),
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecycalebinNew(
                                  deletedNotesNotifier: deletedNotesNotifier,
                                )));
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: secondarycolour,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Recycle bin",
                      style: TextStyle(color: secondarycolour, fontSize: 20),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "....................................................",
                style: TextStyle(letterSpacing: 1),
              )
            ],
          ),
          Row(
            children: [
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.folder,
                    color: secondarycolour,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Folder",
                      style: TextStyle(color: secondarycolour, fontSize: 20),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(minimumSize: Size(300, 30)),
              child: SizedBox(
                width: 50,
                child: Text(
                  "Mange folders",
                  maxLines: 2,
                  softWrap: false,
                  style: TextStyle(color: secondarycolour),
                ),
              ))
        ],
      ),
    );
  }
}
