import 'package:betticos/core/core.dart';
import 'package:flutter/material.dart';

class ImageDivider extends StatelessWidget {
  const ImageDivider({super.key, required this.images, required this.token});

  final List<String> images;
  final String token;

  @override
  Widget build(BuildContext context) {
    if (images.length >= 4) {
      return Column(
        children: <Widget>[
          _buildRowImages(context, images[0], images[1], 107),
          const SizedBox(height: 5),
          _buildRowImages(context, images[2], images[3], 107, itemCount: images.length),
        ],
      );
    } else if (images.length == 2) {
      return _buildRowImages(context, images[0], images[1], 230);
    } else if (images.length == 3) {
      return Row(
        children: <Widget>[
          Expanded(child: _buildImage(context, images[0], 235)),
          const SizedBox(width: 5),
          Expanded(child: _buildColumnImages(context, images[1], images[2], 115)),
        ],
      );
    } else {
      return _buildImage(context, images[0], 158);
    }
  }

  Widget _buildRowImages(BuildContext context, String image1, String image2, double height, {int? itemCount}) {
    return Row(
      children: <Widget>[
        Expanded(child: _buildImage(context, image1, height)),
        const SizedBox(width: 5),
        Expanded(child: _buildImage(context, image2, height, itemCount: itemCount)),
      ],
    );
  }

  Widget _buildColumnImages(BuildContext context, String image1, String image2, double height) {
    return Column(
      children: <Widget>[
        _buildImage(context, image1, height),
        const SizedBox(height: 5),
        _buildImage(context, image2, height),
      ],
    );
  }

  Widget _buildImage(BuildContext context, String imageUrl, double height, {int? itemCount}) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => _FullImage(imageAddress: imageUrl, token: token)),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
            ),
          ),
          if (itemCount != null && itemCount > 4)
            Positioned.fill(
              child: Align(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ColoredBox(
                    color: context.colors.primary.withOpacity(0.5),
                    child: Center(
                      child: Text(
                        '+${itemCount - 4}',
                        style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _FullImage extends StatelessWidget {
  const _FullImage({required this.imageAddress, required this.token});

  final String imageAddress;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Container(
              decoration:
                  BoxDecoration(image: DecorationImage(image: NetworkImage(imageAddress), fit: BoxFit.scaleDown)),
            ),
          ),
        ),
      ),
    );
  }
}
