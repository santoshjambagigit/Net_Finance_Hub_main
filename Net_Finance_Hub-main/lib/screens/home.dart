import 'package:bank/screens/auth/email_auth/login_screen.dart';
import 'package:bank/screens/auth/email_auth/signup_screen.dart';
import 'package:bank/screens/auth/phone_auth/sign_in_with_phone.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imgList = [
    'assets/images/agrloan.jpg',
    'assets/images/carloan.jpg',
    'assets/images/eduloan.jpg',
    'assets/images/goldloan.jpg',
    'assets/images/homeloan.jpg',
    'assets/images/ins.jpg',
    // Add more image paths as needed
  ];

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NETFINANCEHUB'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 123, 236, 246),
              Color.fromARGB(255, 9, 154, 179),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '   Welcome to Net Finance Hub,         The only app you need for banking',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildLoginBox(
                        context,
                        'https://t4.ftcdn.net/jpg/04/24/15/27/360_F_424152729_5jNBK6XVjsoWvTtGEljfSCOWv4Taqivl.jpg',
                        'Student Login',
                        '/login2',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.amber,
                  child: Text(
                    'Hurry up! 👏 Our bank gives student loans with only 1% interest. A golden opportunity for students to achieve their goals and pursue studies without worries. A successful life is waiting for you students.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                CarouselSlider(
                  options: CarouselOptions(height: 400.0, autoPlay: true),
                  items: imgList
                      .map((item) => Container(
                    child: Center(
                      child: Image.asset(item,
                          fit: BoxFit.cover, width: 1000),
                    ),
                  ))
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 232, 214),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: [
                        GestureDetector(
                          onTap: () => _launchURL(
                              'https://chat.whatsapp.com/GSWhigLbnsRBCYEblReFKR'),
                          child: Column(
                            children: [
                              Icon(FontAwesomeIcons.whatsapp,
                                  color: Colors.green, size: 50),
                              Text('Whatsapp')
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _launchURL(
                              'https://www.facebook.com/netfinancehub?mibextid=LQQJ4d'),
                          child: Column(
                            children: [
                              Icon(Icons.facebook, color: Colors.blue, size: 50),
                              Text('Facebook')
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _launchURL(
                              'https://www.instagram.com/netfinancehub?igsh=MW1tMmc5MHp3eDB2bQ=='),
                          child: Column(
                            children: [
                              Icon(FontAwesomeIcons.instagram,
                                  color: Colors.purple, size: 50),
                              Text('Instagram')
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _launchURL(
                              'https://x.com/NETFINANCEHUB?t=Mzwc7yL6ft9YY_I-FA17hw&s=08'),
                          child: Column(
                            children: [
                              Icon(FontAwesomeIcons.xTwitter,
                                  color: Colors.blueAccent, size: 50),
                              Text('TwitterX')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBox(
      BuildContext context, String imgUrl, String title, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            Image.network(imgUrl,
                fit: BoxFit.cover, height: 300, width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(vertical: 12)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text('   Login with      email', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(vertical: 12)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInWithPhone()),
                        );
                      },
                      child: Text('   Login with   phone', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(vertical: 12)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text('Signup', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
