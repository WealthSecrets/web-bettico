import 'package:betticos/core/presentation/utils/app_endpoints.dart';
import 'package:flutter/material.dart';

class TimelineImageDivider extends StatelessWidget {
  const TimelineImageDivider({
    Key? key,
    required this.images,
    required this.token,
  }) : super(key: key);

  final List<String> images;
  final String token;

  @override
  Widget build(BuildContext context) {
    if (images.length == 4) {
      return Column(
        children: <Widget>[
          _buildRowImages(context, images[0], images[1], 107),
          const SizedBox(height: 5),
          _buildRowImages(context, images[2], images[3], 107),
        ],
      );
    } else if (images.length == 2) {
      return _buildRowImages(context, images[0], images[1], 230);
    } else if (images.length == 3) {
      return Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => FullImage(imageAddress: images[0], token: token),
                  ),
                );
              },
              child: Container(
                height: 235,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${AppEndpoints.postImages}/${images[0]}',
                      headers: <String, String>{'Authorization': 'Bearer $token'},
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: _buildColumnImages(
              context,
              images[1],
              images[2],
              115,
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => FullImage(imageAddress: images[0], token: token)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          '${AppEndpoints.postImages}/${images[0]}',
          headers: <String, String>{'Authorization': 'Bearer $token'},
        ),
      ),
    );
  }

  Widget _buildRowImages(BuildContext context, String image1, String image2, double height) {
    return Row(
      children: <Widget>[
        Expanded(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => FullImage(imageAddress: image1, token: token)));
          },
          child: Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(
                  '${AppEndpoints.postImages}/$image1',
                  headers: <String, String>{'Authorization': 'Bearer $token'},
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )),
        const SizedBox(width: 5),
        Expanded(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => FullImage(imageAddress: image2, token: token)));
          },
          child: Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(
                  '${AppEndpoints.postImages}/$image2',
                  headers: <String, String>{'Authorization': 'Bearer $token'},
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildColumnImages(BuildContext context, String image1, String image2, double height) {
    return SizedBox(
      height: 235,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => FullImage(imageAddress: image1, token: token)));
            },
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                    '${AppEndpoints.postImages}/$image1',
                    headers: <String, String>{'Authorization': 'Bearer $token'},
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => FullImage(imageAddress: image2, token: token)));
            },
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                    '${AppEndpoints.postImages}/$image2',
                    headers: <String, String>{'Authorization': 'Bearer $token'},
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FullImage extends StatelessWidget {
  const FullImage({Key? key, required this.imageAddress, required this.token}) : super(key: key);

  final String imageAddress;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    '${AppEndpoints.postImages}/$imageAddress',
                    headers: <String, String>{'Authorization': 'Bearer $token'},
                  ),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
