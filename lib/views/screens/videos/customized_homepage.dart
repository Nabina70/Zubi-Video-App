import 'package:flutter/material.dart';
import 'package:zubi/constants.dart';
import 'package:zubi/views/screens/about/about_us.dart';
import 'package:zubi/views/screens/notifications/NotificationPage.dart';
import 'package:zubi/views/screens/profile/profile_setting_screen.dart';
import 'package:zubi/views/screens/videos/add_video.dart';
import 'package:zubi/views/screens/videos/custompage.dart';
import 'package:zubi/views/screens/videos/search_music_page.dart';
import 'package:zubi/views/screens/videos/search_screen.dart';
import 'package:zubi/views/screens/videos/video_screen.dart';
import 'package:zubi/views/screens/videos/zubi_add_video_page.dart';
import 'package:zubi/views/widgets/CustomIcon.dart';

class CustomizedHomepage extends StatefulWidget {
  const CustomizedHomepage({super.key});

  @override
  State<CustomizedHomepage> createState() => _CustomizedHomepageState();
}

class _CustomizedHomepageState extends State<CustomizedHomepage> {
  int pageIdx = 0;

  // Define the pages
  final List<Widget> pages = [
    const Center(child: CustomPageScreen()),
    const Center(child: SearchMusicPage()),
    Container(),
    Center(child: AboutUs()),
    const Center(child: ProfileSettingScreen()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
        title: const TextField(
          decoration:
              InputDecoration(hintText: "Search", border: InputBorder.none),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Notificationpage()));
            },
          )
        ],
      ),
      body: pages[pageIdx],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          setState(() {
            pageIdx = idx;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),

          BottomNavigationBarItem(icon: Customicon(), label: ''),

          // BottomNavigationBarItem(
          //     icon: Icon(Icons.article),
          //   label: "Articles"
          // ),

          BottomNavigationBarItem(icon: Icon(Icons.article), label: "About Us"),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: pageIdx,
        selectedItemColor: Colors.blue,
        backgroundColor: customHeaderBg,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: const Icon(Icons.add, size: 32),
          onPressed: () {
            // Implementation of add post functionality
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ZubiAddNewVideoPage()));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildSection({required String title, required List<String> images}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '# $title',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Implement See All functionality
                },
                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                    width: 150,
                    height: 100,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
