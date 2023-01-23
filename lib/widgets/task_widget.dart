
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../services/service.dart';

class TaskWidget extends StatefulWidget {
final dynamic data ;
final dynamic date ;
final dynamic uid;
  const TaskWidget({Key? key, required this.data,  required this.date, this.uid}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
      child: SizedBox(
        height: 160,
        width: 400,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left:8.0,top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text('Date : ${widget.date}',style:const  TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                 Flexible(child: Text('Task : ${widget.data}',style:const  TextStyle(fontSize: 18))),
               const SizedBox(height: 20,),
               // Text('${widget.data}',const style: TextStyle(fontSize: 15)),
              Row(
               mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                TextButton(onPressed: (() {
                  showDialog(context: context, builder: (context)=>AlertDialog(
                    actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:const  [
                           Text('Are you sure you want to delete this ?'),
                      ],
                    ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          InkResponse(
                            onTap: () async{
                              Navigator.pop(context);
                              
                              
                            },
                            child: Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child:const  Center(child:  Text('No')),
                                    ),
                          ),
                                  const Spacer(),
                                  InkResponse(
                                    onTap: ()async {
                                      Navigator.pop(context);
                                      var collection = FirebaseFirestore.instance.collection('msgs');
                              var querySnapshots = await collection.get();
                              for (var snapshot in querySnapshots.docs) {
                             var documentID = snapshot.id; // <-- Document ID
                             Services().deletePost(widget.uid.toString());
                             print(widget.uid.toString());
                              }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const  Center(child: Text('Yes')),
                                    ),
                                  ),
                        ],
                      ),
                    ],
                  ));
                 }), child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:const [
                    Icon(Icons.done,color: Colors.green,),
                    Text('Done',style: TextStyle(color: Colors.green),),
                  ],
                )),
               
              ],),
              ],
            ),
          ),
        ),
      ),
    );
  }
}