// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

late User signInUser;

class ChatScreen extends StatefulWidget {
  static const String screenRout = "chat_screen";

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final user = FirebaseAuth.instance.currentUser;

  String? messageText;
  CollectionReference users = FirebaseFirestore.instance.collection('messages');

  getCurrentUser() {
    try {
      if (user != null) {
        signInUser = user!;
        debugPrint(signInUser.email);
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

  // getMessages()async{
  //  final messageGet=await users.get();
  //  for(var message in messageGet.docs){
  //     print(message.data());
  //  }
  // }
  getMessagesStreams() async {
    await for (var snapShot in users.snapshots()) {
      for (var message in snapShot.docs) {
        //  print(message.data());
      }
    }
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('messages').snapshots();

  final TextEditingController editingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Image.asset(
              "images/logo.png",
              height: 50,
            ),
            const Text("messageMe")
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await getMessagesStreams();
                // await FirebaseAuth.instance.signOut();
                // if (!mounted) {
                //   return;
                // }
                // Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // const  SizedBox(height: 200),
          Expanded(
            child: Container(
              color: Colors.white,
              // width: 300,
              // height: 400,
              child: Expanded(child: buildStreamBuilder()),
            ),
          ),
          SizedBox(
            height: 77,
            //color: Colors.blue,
            child: Container(
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.orange, width: 2))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextField(
                    onChanged: (val) {
                      messageText = val;
                    },
                        controller: editingController,
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        hintText: "write your message here .....",
                        border: InputBorder.none),
                  )),
                  TextButton(
                      onPressed: () async {
                        editingController.clear();
                        await users.add(
                            {'text': messageText, 'sender': signInUser.email});
                      },
                      child: Text(
                        "send ",
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> buildStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          padding:const  EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;


            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6,bottom: 2),
                    child: Text(
                      data['sender'].toString(),textAlign: TextAlign.start,
                      style:const  TextStyle(color: Colors.black45, fontSize: 12),
                    ),
                  ),
                   Material(
                     elevation: 5,
                       borderRadius:const  BorderRadius.only(
                         topLeft: Radius.circular(30),
                         bottomLeft: Radius.circular(30),
                         bottomRight: Radius.circular(30),
                       ),
                        color: Colors.blue[800],
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                         child: Text(data['text'].toString(), style:const  TextStyle(color: Colors.white, fontSize: 22),),
                       )),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

// Expanded(
//   flex: 1,

//ListView(
//                     children:
//                         snapshot.data!.docs.map((DocumentSnapshot document) {
//                       Map<String, dynamic> data =
//                           document.data()! as Map<String, dynamic>;
//                       return SizedBox(
//                         height: 100,
//                         child: ListTile(
//                           title: Text(data['text'].toString()),
//                           subtitle: Text(data['sender'].toString()),
//                         ),
//                       );
//                     }).toList(),
//                   ),
