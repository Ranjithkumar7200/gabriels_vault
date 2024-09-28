// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:gabriels_vault/screens/constant/ColorsPalette.dart';
import 'package:gabriels_vault/screens/homescreen/birthdayItems.dart';
import 'package:gabriels_vault/widgets/birthdayList/BirthdayList.dart';
import 'package:gabriels_vault/widgets/bottomnavbar/BottomNavbar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  int _activeIndex = 0;
  int _selectedIndex = 0;
  final List<String> features = ['All', 'Scheduled', 'Draft', 'Delivered'];

  final List<IconData> icons = [
    Icons.list,
    Icons.schedule,
    Icons.drafts,
    Icons.send
  ];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _activeIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  List<BirthdayItem> getFilteredItems(String feature) {
    switch (feature) {
      case 'Scheduled':
        return birthdayItems
            .where((item) => item.status == BirthdayStatus.scheduled)
            .toList();
      case 'Draft':
        return birthdayItems
            .where((item) => item.status == BirthdayStatus.draft)
            .toList();
      case 'Delivered':
        return birthdayItems
            .where((item) => item.status == BirthdayStatus.delivered)
            .toList();
      case 'All':
      default:
        return birthdayItems;
    }
  }

  double _getTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width + 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsPalette.bg,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Gabriels",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: ColorsPalette.main),
            ),
            Text(
              "Vault",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorsPalette.primary),
            ),
          ],
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(features.length, (index) {
              Color iconColor;

              switch (index) {
                case 1:
                  iconColor = Colors.yellow;
                  break;
                case 2:
                  iconColor = Colors.blue;
                  break;
                case 3:
                  iconColor = Colors.green;
                  break;
                default:
                  iconColor = Colors.black;
              }
              final textStyle = TextStyle(
                color: _activeIndex == index
                    ? ColorsPalette.primary
                    : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              );

              double textWidth = _getTextWidth(features[index], textStyle);

              return GestureDetector(
                onTap: () => _onTabSelected(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            icons[index],
                            color: _activeIndex == index
                                ? ColorsPalette.primary
                                : iconColor,
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          Text(
                            features[index],
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: _activeIndex == index
                            ? ColorsPalette.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                      ),
                      child: Container(
                        height: 4,
                        width: textWidth + 20,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
      body: Container(
        color: ColorsPalette.bg,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color.fromARGB(255, 252, 250, 250)),
                      height: 40,
                      width: double.infinity,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Messages',
                          hintStyle:
                              TextStyle(fontSize: 12, color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color:
                                    const Color.fromARGB(255, 233, 229, 229)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color:
                                    const Color.fromARGB(255, 233, 229, 229)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color:
                                    const Color.fromARGB(255, 233, 229, 229)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: const Color.fromARGB(255, 233, 229, 229)),
                    ),
                    height: 40,
                    width: 100,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.filter_alt_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(width: 2),
                            Text(
                              'Filter',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _activeIndex = index;
                  });
                },
                children: features.map((feature) {
                  List<BirthdayItem> filteredItems = getFilteredItems(feature);
                  if (filteredItems.isEmpty) {
                    return Center(
                      child: Text(
                        "No items available for $feature",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return ReusableBirthdayList(birthdays: filteredItems);
                  }
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
