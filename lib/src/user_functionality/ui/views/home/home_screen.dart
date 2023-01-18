import 'package:firebasedemo/src/configs/app_colors.dart';
import 'package:flutter/material.dart';

import 'add_new_thing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Image.asset('assets/images/menu.png',
              color: AppColor.skyTextColor),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/sky_background.png'),
                      fit: BoxFit.fill,
                    )),
                  ),
                  Container(
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black45,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Your\nThings',
                                    style: TextStyle(
                                      fontSize: 26,
                                      color: AppColor.skyTextColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Text('24',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: AppColor.skyTextColor,
                                              fontWeight: FontWeight.w500)),
                                      Text('Personal',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColor.textColor,
                                          )),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Text('15',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: AppColor.skyTextColor,
                                              fontWeight: FontWeight.w500)),
                                      Text('Bussiness',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColor.textColor,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sep 5,2015',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.textColor,
                                    )),
                                Text('65% done',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.textColor,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      height: 230,
                      width: 150,
                      color: Colors.black12,
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height - 230,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'INBOX',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        ListView.separated(
                          padding:
                              const EdgeInsets.only(top: 5, left: 8, right: 8),
                          separatorBuilder: (context, index) =>
                              Container(height: 1, color: Colors.grey[200]),
                          shrinkWrap: true,
                          itemCount: 4,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey[200]!,
                                    )),
                                child: Icon(Icons.accessibility_rounded),
                              ),
                              title: Text(
                                'Lunch Run meeting',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[900],
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                'SubTitle',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Text(
                                  '9am',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            const Text(
                              'COMPLETED',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 5),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Text('5',
                                  style: TextStyle(
                                    color: AppColor.tileColor,
                                    fontSize: 11,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddNewThingScreen(),
                ));
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.skyBackgroundTextColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.kDarkPrimaryColor,
                        blurRadius: 1,
                      ),
                    ]),
                child:
                    const Icon(Icons.add, color: AppColor.tileColor, size: 35),
              ),
            ),
          )
        ],
      ),
    );
  }
}
