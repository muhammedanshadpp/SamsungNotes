import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/extensions/theme/theme_extension.dart';
import 'package:flutter_application_1/core/notes_class.dart';
import 'package:flutter_application_1/core/recycle_bin_page.dart';

// import 'package:flutter_application_1/create_notes.dart';

import 'package:flutter_application_1/drawyer_.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class RecycalebinNew extends HookWidget {
  final ValueNotifier<List<Notes>> deletedNotesNotifier;
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  RecycalebinNew({required this.deletedNotesNotifier});
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).extension<CustomTheme>()!;
    final isout = useState(1.0);
    final isin = useState(0.0);
    final controller = useScrollController();
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

    return Scaffold(
        key: globalKey,
        drawer: DrawerPage(
          deletedNotesNotifier: deletedNotesNotifier,
          primarycolour: themedata.primary,
          secondarycolour: themedata.secondry,
        ),
        body: CustomScrollView(controller: controller, slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: EdgeInsets.only(left: 25, bottom: 70),
                child: AnimatedOpacity(
                  opacity: isout.value,
                  duration: const Duration(seconds: 1),
                  child: Text(
                    "Recycle bin",
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
            pinned: true,
            floating: true,
            automaticallyImplyLeading: false,
          ),
          SliverAppBar(
            toolbarHeight: 18,
            backgroundColor: themedata.primary,
            pinned: true,
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
                      icon: const Icon(
                        Icons.menu_sharp,
                      ),
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
                        "Recycle bin",
                        style: TextStyle(
                            color: themedata.secondry,
                            fontSize: 25,
                            letterSpacing: -1),
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
          SliverToBoxAdapter(
              child: ValueListenableBuilder<List<Notes>>(
            valueListenable: deletedNotesNotifier,
            builder: (context, deletedList, child) {
              return deletedList.isEmpty
                  ? Container(
                      color: themedata.primary,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 150),
                              child: Text(
                                "Recycle bin",
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
                              "Any notes or folders you delete will stay in the trash\nfor 30 days before they are deleted forever.",
                              style: TextStyle(
                                  color: themedata.secondry.withOpacity(0.9)),
                            ),
                          ),
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
                      itemCount: deletedList.length,
                      itemBuilder: (ctx, index) {
                        final showIndex = deletedList[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(context, materialpa)
                            // recyleopenPage(
                            //   index: index,
                            //   recycleNotes: showIndex,
                            // );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => recyleopenPage(
                                        index: index,
                                        recycleNotes: showIndex)));
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
                                      showIndex.title,
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
                                      showIndex.body,
                                      style: TextStyle(
                                        color: themedata.secondry,
                                        fontSize: 16,
                                      ),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // IconButton(
                                      //   icon: Icon(Icons.restore),
                                      //   onPressed: () {
                                      //     // Restore the note back to the main list
                                      //     deletedList.add(showIndex);
                                      //     deletedNotesNotifier.value = [
                                      //       ...deletedNotesNotifier.value
                                      //         ..removeAt(index)
                                      //     ];
                                      //   },
                                      // ),
                                      // IconButton(
                                      //   icon: Icon(Icons.delete_forever),
                                      //   onPressed: () {
                                      //     // Permanently delete the note from the Recycle Bin
                                      //     deletedNotesNotifier.value = [
                                      //       ...deletedNotesNotifier.value
                                      //         ..removeAt(index)
                                      //     ];
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          )),
        ]));
  }
}
