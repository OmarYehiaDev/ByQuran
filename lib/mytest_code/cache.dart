import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CacheImage());

class CacheImage extends StatelessWidget {
  const CacheImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          width: 120,
          child: CachedNetworkImage(
            imageUrl:
                'https://www.popsci.com/uploads/2021/10/05/Windows-11-screenshot.jpg',
            // placeholder: (context, url) => const CircularProgressIndicator(),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        SizedBox(
          height: 120,
          width: 120,
          child: CachedNetworkImage(
            imageUrl:
                'https://www.popsci.com/uploads/2021/10/05/Windows-11-screenshot.jpg',
            // placeholder: (context, url) => const CircularProgressIndicator(),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        SizedBox(
          height: 120,
          width: 120,
          child: CachedNetworkImage(
            imageUrl:
                'https://www.popsci.com/uploads/2021/10/05/Windows-11-screenshot.jpg',
            // placeholder: (context, url) => const CircularProgressIndicator(),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        SizedBox(
          height: 120,
          width: 120,
          child: CachedNetworkImage(
            imageUrl:
                'https://www.popsci.com/uploads/2021/10/05/Windows-11-screenshot.jpg',
            // placeholder: (context, url) => const CircularProgressIndicator(),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ],
    );
  }
}
