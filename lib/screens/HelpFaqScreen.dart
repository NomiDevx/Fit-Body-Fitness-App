import 'package:fbfitnessapp/screens/chatAssitScreen.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';

class HelpFaqScreen extends StatefulWidget {
  const HelpFaqScreen({super.key});

  @override
  State<HelpFaqScreen> createState() => _HelpFaqScreenState();
}

class _HelpFaqScreenState extends State<HelpFaqScreen> {
  int selectedTab = 0; // 0 = FAQ, 1 = Contact Us
  List<bool> expandedTiles = List.generate(5, (_) => false);

  final List<Map<String, dynamic>> contactOptions = [
    {"label": "Customer service", "icon": Icons.support_agent},
    {"label": "Website", "icon": Icons.language},
    {"label": "Whatsapp", "icon": Icons.whatshot},
    {"label": "Facebook", "icon": Icons.facebook},
    {"label": "Instagram", "icon": Icons.camera_alt},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        // toolbarHeight: 110,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                        icon: const Icon(Icons.arrow_left),
                        color: AppColors.secondary,
                      ),

                      Text(
                        'Help & FAQs',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AppColors.heading,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "How Can We Help You?",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => selectedTab = 0),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedTab == 0 ? AppColors.secondary : Colors.white,
                      foregroundColor:
                          selectedTab == 0 ? Colors.black : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("FAQ"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => selectedTab = 1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Chatassitscreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedTab == 1 ? AppColors.secondary : Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Contact Us"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: contactOptions.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Icon(
                        contactOptions[index]['icon'],
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      contactOptions[index]['label'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    iconColor: Colors.yellow,
                    collapsedIconColor: Colors.yellow,
                    backgroundColor: Colors.transparent,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Details about ${contactOptions[index]['label']}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
