import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_app/widget/loading_widget.dart';
import '../const/color.dart';
import '../widget/stream_note.dart';
import 'add_note_screen.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

bool show = true;

class _Home_ScreenState extends State<Home_Screen>  with SingleTickerProviderStateMixin{
  late TabController _tabController;

  late bool _isloading;
  @override
  void initState() {
    super.initState();
    _isloading = false;
    _tabController = TabController(length: 2, vsync: this); // Specify the number of tabs
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose of the TabController to prevent memory leaks
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("TODO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
            Text("(Task Manager)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
          ],
        ),
        titleSpacing: 5,
        leading: Icon(Icons.task, size: 40, color: Colors.deepOrangeAccent,),
        actions: [
          PopupMenuButton(
            iconSize: 30,
              itemBuilder: (context){
                return [
                  PopupMenuItem(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          await FirebaseAuth.instance.signOut();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.logout),
                            Text("Sign Out", style: TextStyle(fontSize: 16),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: InkWell(
                        onTap: ()  {
                          setState(() {
                            _isloading = ! _isloading;
                            Navigator.pop(context);
                          });

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.developer_mode),
                            Text("Widget Tester", style: TextStyle(fontSize: 16),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              }
          )
        ],
        
      ),
      backgroundColor: backgroundColors,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Add_Screen(),
            ));
          },
          backgroundColor: Colors.deepOrangeAccent,
          child: Icon(Icons.add, size: 30),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {

              // setState(() {
              //   show = true;
              // });
            }
            if (notification.direction == ScrollDirection.reverse) {
              // setState(() {
              //   show = false;
              // });
            }
            return true;
          },
          child: Column(
            children: [
              TabBar(
                labelStyle: TextStyle(fontSize:18, fontWeight: FontWeight.bold),
                controller: _tabController,
                tabs: const [
                  Tab(text: "Scheduled"),
                  Tab(text: "Completed"),
                ],
              ),
              Expanded(
                child: SizedBox(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _isloading ?Center(child: LoadingWidget()): Stream_note(false),
                      _isloading ?Center(child: LoadingWidget()): Stream_note(true),
                    ]
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}