import 'package:drdrakify/common/helpers/is_dark_mode.dart';
import 'package:drdrakify/common/widgets/app_bar.dart';
import 'package:drdrakify/core/configs/assets/images.dart';
import 'package:drdrakify/core/configs/themes/Slideshow.dart';
import 'package:drdrakify/prsentation/home/widgets/news_songs.dart';
import 'package:drdrakify/prsentation/home/widgets/playlist.dart';
import 'package:drdrakify/prsentation/profile/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: true,
        title: const Image(
          image: AssetImage('${AppImages.basepath}logo.png'),
          height: 45,
          width: 45,
        ),
        action: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
              icon: Icon(
                Icons.person,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ProfilePage(),
                  ),
                );
              }),
        ),
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //_arianaBlock(),
              AutoSlidingCarousel(widgets: [
                _duaLipaBlock(),
                _weekndBlock(),
                _drakeBlock(),
                _arianaBlock()
              ]),
              _tabs(),
              SizedBox(
                height: 240,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    const NewsSongs(),
                    TestImage(),
                    Container(),
                    Container()
                  ],
                ),
              ),
              const Playlist()
            ],
          ),
        ),
      ),
    );
  }

  Widget _duaLipaBlock() {
    return const Center(
      child: SizedBox(
        height: 160,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image(
                image: AssetImage(AppImages.dua_lipa_frame),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 90),
                child: Image(image: AssetImage(AppImages.dua_lipa)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _weekndBlock() {
    return const Center(
      child: SizedBox(
        height: 160,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image(
                image: AssetImage(AppImages.weeknd_frame),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 90),
                child: Image(image: AssetImage(AppImages.weeknd)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _drakeBlock() {
    return const Center(
      child: SizedBox(
        height: 160,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image(
                image: AssetImage(AppImages.drake_frame),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 90),
                child: Image(image: AssetImage(AppImages.drake)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _arianaBlock() {
    return const Center(
      child: SizedBox(
        height: 160,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image(
                image: AssetImage(AppImages.ariana_frame),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 90),
                child: Image(image: AssetImage(AppImages.ariana)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        unselectedLabelColor: context.isDarkMode ? Colors.grey : Colors.black54,
        indicatorColor: const Color.fromARGB(255, 200, 3, 244),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        tabs: const [
          Text(
            'News',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Text(
            'Albums',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Text(
            'Artists',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Text(
            'Podcasts',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          )
        ]);
  }
}

class TestImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://firebasestorage.googleapis.com/v0/b/drdrakify.appspot.com/o/covers%2FAriana%20Grande%20-%207%20rings.jpeg?alt=media',
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/placeholder.png');
      },
    );
  }
}
