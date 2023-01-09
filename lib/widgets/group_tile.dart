import 'package:chatapp/service/database_service.dart';
import 'package:chatapp/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../pages/chat_page.dart';

class GroupTile extends StatefulWidget {
  final String username;
  final String groupId;
  final String groupName;

  const GroupTile(
      {super.key,
      required this.username,
      required this.groupId,
      required this.groupName});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  String lastMessage = "";

  @override
  void initState() {
    glastMessage();
    super.initState();
  }

  String glastMessage() {
    DatabaseService().getLastMessage(widget.groupId).then((value) {
      setState(() {
        lastMessage = value;
      });
    });

    return lastMessage;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ChatPage(
              groupId: widget.groupId,
              groupName: widget.groupName,
              userName: widget.username,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          title: Text(
            widget.groupName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            glastMessage(),
            style: const TextStyle(fontSize: 13),
          ),

          /* StreamBuilder(
            stream: lastMessage,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Text(
                      snapshot.data.toString(),
                      style: TextStyle(fontSize: 13),
                    )
                  : const Text(
                      "",
                      style: TextStyle(fontSize: 13),
                    );
            },
          ), */
        ),
      ),
    );
  }
}
