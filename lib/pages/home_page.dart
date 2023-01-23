import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:to_do/pages/time.dart';

import '../widgets/task_widget.dart';
bool color1 = false ; 
bool color2 = false ;
bool color3 = false ;
String type = "";
List  children=[];
 TextEditingController whatabout=TextEditingController() ;
TextEditingController time = TextEditingController();
class HomePage extends StatefulWidget {
    const HomePage({Key? key}) : super(key: key);

  @override
  
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasInternet = false;

 

  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }
 @override
  bool check (){
    InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      this.hasInternet = hasInternet ;     
  });
  setState(() {
        final _text1 = hasInternet ? "Internet "   : "No Internet ";
       final _color = hasInternet ? Colors.green : Colors.red ;
      });
  return hasInternet;}*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        backgroundColor:const  Color.fromARGB(255, 95, 96, 100),
        onPressed: () {
        showDialog(context: context, builder: (context)=>AlertDialog(
                title:Center(child: const Text('Fill the form')),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('About what'),
                       SizedBox(height: 20,),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Flexible(
                    child: TextField(
                      autofocus: true,
                      textAlign: TextAlign.justify,
                      keyboardType: TextInputType.multiline,
                      controller: whatabout,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text('To when'),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) =>  Time1(whatabout: whatabout.text)));
                          print(whatabout.text);
                        },
                        child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(Icons.calendar_month),
                              ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child:const  Text('Cancel')),
                  ],)
                  
                ],
              )
              );
      },
      child:const  Icon(Icons.add),
      ),
    
      body: SafeArea(
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:30),
          child: Column(
            children:  [
              
              Container(
                height: 50,
                width: double.infinity,
                child: Center(child: Text( "      Hello !  " ,style: TextStyle(fontSize: 30),  ))),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('msgs').snapshots(),
                builder:  ( BuildContext context, snapshot)  { 
                if(snapshot.hasData){
                return RefreshIndicator(
                  onRefresh: () {
            InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      this.hasInternet = hasInternet ;  
  }); 
  
   ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                duration: Duration(seconds: 3),
                                backgroundColor: hasInternet ? Colors.green:Colors.redAccent,
                                content:
                                    Text(hasInternet ? 'Active Internet' :"No Internet ")));
   
     return Future.delayed(Duration(seconds: 2));
          },
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    physics:const  AlwaysScrollableScrollPhysics (),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {              
                    if(snapshot.hasData )
                      {
                        if (snapshot.data!.docs.isEmpty) {
                  print("vide");
                }else{
                      print(snapshot.data!.docs.length);
                      return TaskWidget(data: snapshot.data!.docs[index]["data"], date: snapshot.data!.docs[index]["date"],uid: snapshot.data!.docs[index].id,);
                }}
                     
                    if(snapshot.connectionState== ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                      }
                        if(snapshot.hasError){
                        return  const Center(child: Text("ERROR",style: TextStyle(color: Colors.red),));
                      }
                       print(2);
                        return Container();
                      }
                     
                  ))
;                  
                  
                      }
                if (snapshot.connectionState==ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                  if (snapshot.hasError) {
                    return const Center(child: Text('ERROR',style: TextStyle(color: Colors.red),),);
                  }
                
               return Container(
                color: Colors.red,
                height: 100,
                width: 20,
               ); 
              })
              ],
          ),
        ),
            )),
    );
  }
}