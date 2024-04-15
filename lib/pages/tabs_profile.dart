import 'package:flex_education/components/post_card.dart';
import 'package:flex_education/services/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsProfile extends StatefulWidget {
  @override
  _TabsProfileState createState() => _TabsProfileState();
}

class _TabsProfileState extends State<TabsProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<MyProvider>(context, listen: false).getLikedPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final likedPost = snapshot.data;
          if (likedPost == [] || likedPost == null) {
            return SizedBox();
          }
          return SizedBox(
            height: 600, // Set a fixed height for the Column
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 300,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor:
                        Color(0xFF8085ef), // Set indicator color to purple
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: 'Courses Liked',
                      ),
                      Tab(
                        text: 'Courses Completed',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // Use Expanded to allow TabBarView to occupy remaining space
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                              child: Column(
                            children: [PostCard(course: likedPost)],
                          ))),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              // PostCard(),
                            ],
                          ))),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
