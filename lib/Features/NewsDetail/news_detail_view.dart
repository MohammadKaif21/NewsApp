import 'package:flutter_application/Components/cache_image.dart';
import 'package:flutter_application/Components/image_view.dart';
import 'package:flutter_application/Utilities/home_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsDetailView extends StatelessWidget {
  final NewsData article;
  const NewsDetailView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
        title: Text(article.source?.name ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ImageView(imageId: 0, imageUrl: article.urlToImage ?? ""),
                  transitionDuration: const Duration(milliseconds: 500),
                  reverseTransitionDuration: const Duration(milliseconds: 500),
                ),
              ),
              child: CacheImage(fit: BoxFit.cover, width: size.width, height: size.width / 2, image: article.urlToImage ?? ""),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(article.title ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person, size: 16),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  maxLines: 2,
                                  article.author ?? "",
                                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month, size: 16),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  maxLines: 1,
                                  DateFormat.yMMMd().format(DateTime.parse("${article.publishedAt ?? ""}")),
                                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _launchInBrowser(article.url ?? ""),
                    icon: const Icon(Icons.launch),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                article.description ?? "",
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
              child: Text(
                article.content ?? "",
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    final browserURL = Uri.parse(url);
    if (!await launchUrl(browserURL, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
