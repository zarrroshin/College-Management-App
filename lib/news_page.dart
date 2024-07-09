import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'خبرها',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.indigo,
          bottom: TabBar(
            tabs: [
              Tab(text: 'اخبار عمومی'), // Tab titles
              Tab(text: 'رویدادها'),
              Tab(text: 'دستاوردها'),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1 content (General News)
            GeneralNewsTab(),
            // Tab 2 content (Events)
            Events(),
            // Tab 3 content (Achievements)
            Achievements(),
          ],
        ),
      ),
    );
  }
}

class GeneralNewsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        NewsCard(
          title: 'همایش جوانی جمعیت                                                 ',
          description:
          'همایش جوانی جمعیت، سه شنبه 12 تیر 1403 همزمان با روز مباهله پیامبر (ص) در دانشگاه شهید بهشتی برگزار شد',
          url: 'https://www.sbu.ac.ir/home5/-/asset_publisher/KkFrxP58GmrV/content/population-1/3740662?_com_liferay_asset_publisher_web_portlet_AssetPublisherPortlet_INSTANCE_KkFrxP58GmrV_assetEntryId=307609533&_com_liferay_asset_publisher_web_portlet_AssetPublisherPortlet_INSTANCE_KkFrxP58GmrV_redirect=https%3A%2F%2Fwww.sbu.ac.ir%2Fhome5%3Fp_p_id%3Dcom_liferay_asset_publisher_web_portlet_AssetPublisherPortlet_INSTANCE_KkFrxP58GmrV%26p_p_lifecycle%3D0%26p_p_state%3Dnormal%26p_p_mode%3Dview%26_com_liferay_asset_publisher_web_portlet_AssetPublisherPortlet_INSTANCE_KkFrxP58GmrV_cur%3D0%26p_r_p_resetCur%3Dfalse%26_com_liferay_asset_publisher_web_portlet_AssetPublisherPortlet_INSTANCE_KkFrxP58GmrV_assetEntryId%3D307609533',
          imageUrl:
          'https://news.sbu.ac.ir/documents/3740662/305573774/%D9%86%D8%B4%D8%B3%D8%AA+%D8%AC%D9%88%D8%A7%D9%86%DB%8C+%D8%AC%D9%85%D8%B9%DB%8C%D8%AA-+%D8%AA%DB%8C%D8%B1+1403+%2842%29.jpg/88bbf964-7b97-b984-f146-91234fda6896?t=1719986819300', // Example image URL
        ),
        NewsCard(
          title: 'ایران قدرتمندانه مسیر هسته ای را دنبال میکند                         ',
          description:
          'آیین افتتاحیه سومین دوره آموزشی- فرهنگی با هدف توانمندسازی دانشجویان بین‌الملل و آشنایی بیشتر با مبانی اندیشه اسلامی، شنبه 16 تیر 1403در سالن همایش‌های بین‌المللی دانشگاه شهید بهشتی برگزار شد',
          url: 'https://www.sbu.ac.ir/fa/web/news/w/international-4?redirect=%2F',
          imageUrl:
          'https://news.sbu.ac.ir/documents/3740662/307612523/%D8%B3%D9%88%D9%85%DB%8C%D9%86+%D8%AC%D8%B4%D9%86%D9%88%D8%A7%D8%B1%D9%87+%D8%A2%D9%85%D9%88%D8%B2%D8%B4%DB%8C+%D9%88+%D9%81%D8%B1%D9%87%D9%86%DA%AF%DB%8C+%D8%AF%D8%A7%D9%86%D8%B4%D8%AC%D9%88%DB%8C%D8%A7%D9%86+%D8%AE%D8%A7%D8%B1%D8%AC%DB%8C-+%D8%AA%DB%8C%D8%B1+1403+%2825%29.jpg/7eea2533-71fe-8e23-0527-f32495724b54?t=1720260109544', // Example image URL
        ),
      ],
    );
  }
}

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        NewsCard(
          title: 'ششمین کنگره بین المللی و هجدهمین کنگره ژنتیک                    ',
          description:
          'ششمین کنگره بین‌المللی و هجدهمین کنگره ملی ژنتیک 17 تا 19 تیر 1403 در دانشگاه شهید بهشتی برگزار می‌شود',
          url: '',
          imageUrl:
          'https://www.sbu.ac.ir/documents/46019/211038383/%DA%A9%D9%86%D9%81%D8%B1%D8%A7%D9%86%D8%B3+%DA%98%D9%86%D8%AA%DB%8C%DA%A9.jpg/5c7020d9-e5de-2e0b-8f4c-0fec8f9f96cd?t=1720260716270', // Example image URL
        ),
        NewsCard(
          title: 'برنامه های دانشگاه شهید بهشتی برای محرم                          ',
          description:
          'آیین عزاداری سید و سالار شهیدان حضرت اباعبدالله الحسین (ع) در دهه اول محرم در دانشگاه شهید بهشتی برگزار می‌شود',
          url: '',
          imageUrl:
          'https://www.sbu.ac.ir/documents/46019/211038383/%D8%B9%D8%B2%D8%A7%D8%AF%D8%A7%D8%B1%DB%8C+%D9%85%D8%AD%D8%B1%D9%85+-1403.jpg/6a0ea2b7-408e-54aa-0adf-d1546ec6e8d0?t=1720246054532', // Example image URL
        ),
      ],
    );
  }
}

class Achievements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        NewsCard(
          title: 'دانشجوی دانشگاه شهید بهشتی دانشجو نمونه کشوری شد  ',
          description:
          'در سی و یکمین جشنواره دانشجوی نمونه کشور، دانشجوی دانشگاه شهید بهشتی به‌عنوان دانشجوی نمونه کشور معرفی شد',
          url: '',
          imageUrl:
          'https://www.sbu.ac.ir/documents/46019/223365089/1346170.jpg/eb299d8b-a961-80c7-9411-b4e812ad8d8e?t=1719895404670', // Example image URL
        ),
        NewsCard(
          title: 'کتاب مرجع کارکردهای اجرایی منتشر شد                              ',
          description:
          'این کتاب برای نخستین بار در سال 1402، در 710 صفحه، در قطع رحلی و در انتشارات دانشگاه شهید بهشتی منتشر شده است و با قیمت 4.260.000 ریال عرضه می‌شود.',
          url: '',
          imageUrl:
          'https://www.sbu.ac.ir/documents/46019/49433389/%DA%A9%D8%AA%D8%A7%D8%A8+%D9%85%D8%B1%D8%AC%D8%B9+%DA%A9%D8%A7%D8%B1%DA%A9%D8%B1%D8%AF%D9%87%D8%A7%DB%8C+%D8%A7%D8%AC%D8%B1%D8%A7%DB%8C%DB%8C.jpg/771e9afb-e621-f1dc-1205-73e6118f22dd?t=1719385882285', // Example image URL
        ),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String url;
  final String? imageUrl; // Optional image URL

  const NewsCard({
    required this.title,
    required this.description,
    required this.url,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          if (url.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsWebViewPage(url: url),
              ),
            );
          } else {
            // Handle case where URL is empty (optional)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('No URL available for this news.'),
              ),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  imageUrl!,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
                    ),
                  ),
                  SizedBox(height: 8),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      description,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsWebViewPage extends StatelessWidget {
  final String url;

  const NewsWebViewPage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) {
          print('Page finished loading: $url');
        },
        onWebResourceError: (error) {
          print('Webview error: $error');
        },
      ),
    );
  }
}
