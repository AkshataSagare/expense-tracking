import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> transactionsData= [
  {
    'icon': FaIcon(FontAwesomeIcons.burger, color: Colors.white,),
    'color': Colors.yellow[700],
    'name': 'Food',
    'totalAmount': '-₹450.00',
    'date': 'Today',
  },
  {
    'icon': FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white,),
    'color': Colors.purple,
    'name': 'Shopping',
    'totalAmount': '-₹2300.00',
    'date': 'Today',
  },
  {
    'icon': FaIcon(FontAwesomeIcons.heartCircleCheck, color: Colors.white,),
    'color': Colors.green,
    'name': 'Health',
    'totalAmount': '-₹790.00',
    'date': 'Yesterday',
  },
  {
    'icon': FaIcon(FontAwesomeIcons.plane, color: Colors.white,),
    'color': Colors.blue,
    'name': 'Travel',
    'totalAmount': '-₹3500.00',
    'date': 'Yesterday',
  }
];