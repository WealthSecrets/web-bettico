import 'package:betticos/core/core.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoTab extends StatelessWidget {
  const PromoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          child: Transform.translate(
            offset: const Offset(0.0, -260.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CarouselSlider(
                  items: const <Widget>[
                    Image(
                      image: NetworkImage(
                          'https://www.thebettingcoach.com/wp-content/uploads/2020/08/Melbet-banner-728x90-thebettingcoach-1.jpg'),
                      fit: BoxFit.contain,
                    ),
                    Image(
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQS6TsR43z_TMg52Yein3oNgIof65oBYkq4JXxAXWKwPIKdRPX94B2JafW1RsIREDvH4Q&usqp=CAU'),
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 24 / 3,
                    autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(milliseconds: 300),
                    viewportFraction: 1.0,
                  ),
                ),
                const SizedBox(height: 9.0),
                DetectableText(
                  trimLines: 2,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'more',
                  trimExpandedText: '...less',
                  text: 'Tap: https://bit.ly/melbet-bettico',
                  detectionRegExp: RegExp(
                    '(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent',
                    multiLine: true,
                  ),
                  callback: (bool readMore) {
                    debugPrint('Read more >>>>>>> $readMore');
                  },
                  onTap: (String tappedText) async {
                    // ignore: avoid_print
                    print(tappedText);
                    if (tappedText.startsWith('#')) {
                      debugPrint('DetectableText >>>>>>> #');
                    } else if (tappedText.startsWith('@')) {
                      debugPrint('DetectableText >>>>>>> @');
                    } else if (tappedText.startsWith('http')) {
                      _launchURL(tappedText);
                    }
                  },
                  basicStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 0.5,
                  ),
                  detectedStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 0.5,
                    color: context.colors.primary,
                  ),
                ),
                const SelectableText(
                  'promocode: betworld2022',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        CarouselSlider(
          items: <Widget>[
            Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://melbet.com.gh/img/banners/main/home_page_main_section/202.jpg?v=1010022910'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'MELBET',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'fast_betting'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyKuwPx-xSzgZxm-RQ8Z0cz4Aqunnt2a178w&usqp=CAU'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'sporting'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'sport_news'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-I-VS-cZT4Q424GvkVZnYNZZoC1JQL13e9-ZhDgik79NRxF41kBKINUDaWlmZPrwUp4g&usqp=CAU'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'online_odds'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'have_lost'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
          options: CarouselOptions(
            height: 200.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 500),
            viewportFraction: 0.8,
          ),
        )
      ],
    );
  }

  void _launchURL(String url) async {
    if (!await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
