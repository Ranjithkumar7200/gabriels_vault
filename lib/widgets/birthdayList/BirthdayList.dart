// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gabriels_vault/screens/constant/ColorsPalette.dart';
import 'package:intl/intl.dart';

class ReusableBirthdayList extends StatelessWidget {
  final List<BirthdayItem> birthdays;
  final Function(BirthdayItem)? onItemTap;
  final Widget? emptyListWidget;
  final EdgeInsets itemPadding;
  final double avatarRadius;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;

  ReusableBirthdayList({
    Key? key,
    required this.birthdays,
    this.onItemTap,
    this.emptyListWidget,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.avatarRadius = 30,
    this.titleStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    this.subtitleStyle = const TextStyle(color: Colors.grey, fontSize: 14),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (birthdays.isEmpty && emptyListWidget != null) {
      return emptyListWidget!;
    }

    return ListView.builder(
      itemCount: birthdays.length,
      itemBuilder: (context, index) {
        return BirthdayListItem(
          birthday: birthdays[index],
          onTap: onItemTap,
        );
      },
    );
  }
}

class BirthdayListItem extends StatelessWidget {
  final BirthdayItem birthday;
  final Function(BirthdayItem)? onTap;

  BirthdayListItem({
    required this.birthday,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: const Color.fromARGB(255, 233, 229, 229)),
      ),
      color: ColorsPalette.bg,
      child: InkWell(
        onTap: onTap != null ? () => onTap!(birthday) : null,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorsPalette.bg,
                      image: DecorationImage(
                        image: AssetImage(birthday.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Birthday Celebration',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(
                          '${birthday.createAt}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: ColorsPalette.textSecondary),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundImage: AssetImage(birthday.imagePath),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${birthday.name}',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'Scheduled Date',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorsPalette.textSecondary),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${_formatDate(birthday.scheduledDate)}',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: _buildStatusIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: _getStatusColor(),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _getStatusIcon(),
        color: Colors.white,
        size: 10,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  Color _getStatusColor() {
    switch (birthday.status) {
      case BirthdayStatus.scheduled:
        return Colors.orange;
      case BirthdayStatus.delivered:
        return Colors.green;
      case BirthdayStatus.draft:
        return Colors.blue;
    }
  }

  IconData _getStatusIcon() {
    switch (birthday.status) {
      case BirthdayStatus.scheduled:
        return Icons.schedule;
      case BirthdayStatus.delivered:
        return Icons.check_circle;
      case BirthdayStatus.draft:
        return Icons.drafts;
    }
  }
}

class BirthdayItem {
  final String name;
  final String imagePath;
  final DateTime scheduledDate;
  final BirthdayStatus status;
  final String createAt;

  BirthdayItem({
    required this.name,
    required this.imagePath,
    required this.scheduledDate,
    required this.status,
    required this.createAt,
  });
}

enum BirthdayStatus {
  scheduled,
  delivered,
  draft,
}
