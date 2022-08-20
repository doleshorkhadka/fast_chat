import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageStreams extends StatelessWidget {
  MessageStreams({
    Key? key,
    required FirebaseFirestore firestore,
    required this.currentUser,
  })  : _firestore = firestore,
        super(key: key);

  final FirebaseFirestore _firestore;
  User currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final msgLists = snapshot.requireData.docs;

        List<MessageBubbles> tiles = [];
        for (var message in msgLists) {
          try {
            String msgUser = message.get('sender');
            tiles.add(MessageBubbles(
              message: message,
              isOwner: msgUser == currentUser.email,
            ));
          } catch (e) {
            print(e);
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: tiles,
          ),
        );
      }),
    );
  }
}

class MessageBubbles extends StatelessWidget {
  MessageBubbles({
    Key? key,
    required this.message,
    required this.isOwner,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> message;
  bool? isOwner;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment:
            isOwner! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: isOwner!
                ? const EdgeInsets.only(right: 5)
                : const EdgeInsets.only(left: 5),
            child: Text(
              '${message.get('sender')}',
              style: TextStyle(
                color: Colors.black87.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ),
          Material(
            elevation: 5,
            color: isOwner! ? Colors.lightBlue : Colors.white70,
            borderRadius: isOwner!
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '${message.get('text')}',
                style: TextStyle(
                  color: isOwner! ? Colors.white : Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
