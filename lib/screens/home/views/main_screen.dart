import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10 ),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow[700]
                      ),
                    ),
                    Icon(
                      CupertinoIcons.person_fill,
                      color: Colors.yellow[800],
                      size: 30,
                    )
                  ],
                ),
                SizedBox(width: 6,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome!",
                      style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.outline
                      ),
                    ),

                    Text("Akshata",
                      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface
                      ),
                    ),

                  ]
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.settings),
                )
              ],
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.tertiary,
                  ],
                  transform: const GradientRotation(pi / 4),  
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.grey.shade300,
                    offset: Offset(5, 5)
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 12,),
                  Text(
                    'Rs 48000.00',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 12,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle
                              ),
                              child: Center(
                                child: Icon(
                                  CupertinoIcons.arrow_down,
                                  size: 15,
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Income',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                                Text(
                                  'Rs 25000.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle
                              ),
                              child: Center(
                                child: Icon(
                                  CupertinoIcons.arrow_down,
                                  size: 15,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expense',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                                Text(
                                  'Rs 2500.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Text(
                  'Transactions',
                  style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold
                  )
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Text(
                    'View all',
                    style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.outline,
                    fontWeight: FontWeight.w500
                    )
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            ListView()
          ],
        ),
      ),
    );
  }
}