import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'controller/schadules_detailed_controller.dart';

class SchadulesDetailedImageScreen extends StatelessWidget {
  final String? link;

  const SchadulesDetailedImageScreen({Key? key, this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize controller with GetX
    final SchadulesDetailedController controller =
    Get.put(SchadulesDetailedController(), permanent: false);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: 'imageHero',
              child: PinchZoom(
                maxScale: 3.5,
                onZoomStart: () => debugPrint('Start zooming'),
                onZoomEnd: () => debugPrint('Stop zooming'),
                child: CachedNetworkImage(
                  imageUrl: link ?? "",
                  imageBuilder: (context, image) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                      ),
                    );
                  },
                  placeholder: (context, image) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                          AssetImage("assets/images/no_data_slideShow.png"),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Get.back(); // Use GetX for navigation
              },
              child: const Icon(
                Icons.clear_outlined,
                color: Colors.black,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
