import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/extensions/theme/theme_extension.dart';
import 'package:flutter_application_1/core/notes_class.dart';
import 'package:flutter_application_1/create_notes.dart';
import 'package:flutter_application_1/drawyer_.dart';
import 'package:flutter_application_1/updates.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FirstPage extends HookWidget {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  final ValueNotifier<List<Notes>> notifier = ValueNotifier([]);

  final ValueNotifier<List<Notes>> deletedNotesNotifier;
  
        
  FirstPage({required this.deletedNotesNotifier});

  void onUpdatedNotes(int index, String updatedTitle, String updatedBody) {
    if (index >= 0 && index < notifier.value.length) {
      final updatedNote = Notes(body: updatedBody, title: updatedTitle);
      notifier.value[index] = updatedNote;
      notifier.notifyListeners();
    }
  }

  void onAddnotes(String title, String body) {
    if (title.isNotEmpty && body.isNotEmpty) {
      final newNote = Notes(title: title, body: body);
      notifier.value.add(newNote); // Add note to the list
      notifier.notifyListeners(); // Notify listeners to update UI
    }
  }

  void moveToRecycleBin(int index) {
    
    // Get the note you want to move
    final noteToMove = notifier
        .value[index]; // Assuming notesNotifier holds the main list of notes
    

    // Add it to the deleted (recycle bin)
    deletedNotesNotifier.value = [
      ...deletedNotesNotifier.value, // Current deleted notes
      noteToMove,
    ];
    

    notifier.value.removeAt(index);
    notifier.notifyListeners();
    print("Updated Notes List: ${notifier.value}");
  }

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).extension<CustomTheme>()!;
    final isout = useState(1.0);
    final isin = useState(0.0);
    final controller = useScrollController();

    // Scroll controller listener to change opacity based on scroll
    useEffect(() {
      controller.addListener(() {
        if (controller.offset > 40) {
          isout.value = 0.0;
          isin.value = 1.0;
        } else {
          isout.value = 1.0;
          isin.value = 0.0;
        }
      });
      return () => controller.dispose();
    }, [controller]);

    bool pinned = true;

    return Scaffold(
      key: globalKey,
      drawer: DrawerPage(
        deletedNotesNotifier: deletedNotesNotifier,
        primarycolour: themedata.primary,
        secondarycolour: themedata.secondry,
      ),
      body: CustomScrollView(
        controller: controller,
        slivers: [
          // First SliverAppBar with title
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: EdgeInsets.only(left: 25, bottom: 70),
                child: AnimatedOpacity(
                  opacity: isout.value,
                  duration: const Duration(seconds: 1),
                  child: Text(
                    "All notes",
                    style: TextStyle(color: themedata.secondry, fontSize: 25),
                  ),
                ),
              ),
              centerTitle: true,
            ),
            expandedHeight: 300,
            toolbarHeight: 30,
            backgroundColor: themedata.primary,
            elevation: 0,
            pinned: pinned,
            floating: true,
            automaticallyImplyLeading: false,
          ),
          // Second SliverAppBar for subtext and menu button
          SliverAppBar(
            toolbarHeight: 18,
            backgroundColor: themedata.primary,
            pinned: pinned,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        globalKey.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu_sharp),
                      color: themedata.secondry,
                    ),
                  ),
                  Positioned(
                    left: 70,
                    top: 4,
                    child: AnimatedOpacity(
                      curve: Curves.easeInOut,
                      opacity: isin.value,
                      duration: Duration(seconds: 1),
                      child: Text(
                        "No notes",
                        style: TextStyle(
                          color: themedata.secondry,
                          fontSize: 25,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 350,
                    top: 7,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert),
                      color: themedata.secondry,
                    ),
                  )
                ],
              ),
            ),
          ),
          // Content for displaying notes
          SliverToBoxAdapter(
            child: ValueListenableBuilder<List<Notes>>(
              valueListenable: notifier,
              builder: (ctx, notelist, child) {
                return notelist.isEmpty
                    ? Container(
                        color: themedata.primary,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 150),
                                child: Text(
                                  "No notes",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: themedata.secondry.withOpacity(0.8),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "Create text",
                                style: TextStyle(
                                  color: themedata.secondry.withOpacity(0.9),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 2 / 3,
                        ),
                        itemCount: notelist.length,
                        itemBuilder: (ctx, index) {
                          final note = notelist[index];
                          return GestureDetector(
                            onLongPress: () {
                              
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => UpdatesNotes(
                                    // index: index,
                                    // notess: note,
                                    // onUpdated: onUpdatedNotes,=
                                    // moveToRecycleBin: moveToRecycleBin,
                                    index: index,
                                    onUpdated: onUpdatedNotes,
                                    notess: note,
                                    moveToRecycleBin: moveToRecycleBin,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              color: themedata.primary,
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8.0),
                                    Center(
                                      child: Text(
                                        note.title,
                                        style: TextStyle(
                                          color: themedata.secondry,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Expanded(
                                      child: Text(
                                        note.body,
                                        style: TextStyle(
                                          color: themedata.secondry,
                                          fontSize: 16,
                                        ),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateNotes(
                      onAddnotes: onAddnotes,
                    )),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: const Color.fromARGB(255, 71, 70, 49),
        child: Icon(
          Icons.mode_edit_outline_sharp,
          color: const Color.fromARGB(255, 226, 89, 9),
        ),
      ),
    );
  }
}
