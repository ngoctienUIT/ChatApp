import 'package:chat_app/chat/models/messages.dart';
import 'package:chat_app/chat/widgets/message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/chat/models/user.dart' as myuser;

class ShowInfoReaction extends StatefulWidget {
  const ShowInfoReaction({Key? key, required this.messages}) : super(key: key);

  final Messages messages;

  @override
  State<ShowInfoReaction> createState() => _ShowInfoReactionState();
}

class _ShowInfoReactionState extends State<ShowInfoReaction>
    with TickerProviderStateMixin {
  late TabController tabController;
  late List<dynamic> listReact;

  @override
  void initState() {
    listReact = widget.messages.reaction!.values.toSet().toList();
    tabController = TabController(length: listReact.length + 1, vsync: this);
    tabController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.messages.reaction!.keys.length,
              itemBuilder: (context, index) {
                if (tabController.index == 0 ||
                    widget.messages.reaction!.values.elementAt(index) ==
                        listReact[tabController.index - 1]) {
                  return Row(
                    children: [
                      FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection("users")
                              .doc(widget.messages.reaction!.keys
                                  .elementAt(index))
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              myuser.User user = myuser.User.fromFirebase(
                                  snapshot.requireData);
                              return Text(
                                user.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }

                            return Container();
                          }),
                      const Spacer(),
                      Text(
                        react[
                            widget.messages.reaction!.values.elementAt(index)],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          Container(
            height: 40,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              controller: tabController,
              labelColor: Colors.black87,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              isScrollable: true,
              indicatorColor: Colors.red,
              indicator: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
              tabs: [
                const Tab(text: "All"),
                ...List.generate(
                  listReact.length,
                  (index) => Tab(text: react[listReact[index]]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
