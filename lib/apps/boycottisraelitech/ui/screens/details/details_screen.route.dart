import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:boycott_hub/apps/boycottisraelitech/features/companies/models/company_res_model.dart';
import 'package:boycott_hub/apps/boycottisraelitech/features/companies/states/cached_logo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

@RoutePage(
  name: DetailsScreen.name,
)
class DetailsScreen extends ConsumerWidget {
  static const name = "BoycottIsraeliTech_DetailsScreenRoute";
  static const path = "/DetailsScreen";
  final CompanyModel companyModel;

  DetailsScreen({super.key, required this.companyModel});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).appBarTheme.foregroundColor,
              ),
              onPressed: () {
                AutoRouter.of(context).pop();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(companyModel.name,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                  )),
              background: ColorFiltered(
                colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.28), BlendMode.darken),
                child: Container(
                  color: Colors.white,
                  child: ref.watch(cachedLogoProvider(companyModel.fixedLogo)).when(
                    data: (data) {
                      if (data == null) {
                        return Container();
                      }

                      if (companyModel.logoType == ".avif") {
                        return AvifImage.file(
                          data,
                          errorBuilder: (context, error, stackTrace) {
                            return Container();
                          },
                          fit: BoxFit.contain,
                        );
                      } else if (companyModel.logoType == ".svg") {
                        return SizedBox(
                          child: SvgPicture(
                            SvgStringLoader(data.readAsStringSync()),
                            fit: BoxFit.contain,
                          ),
                        );
                      } else {
                        return Image.file(
                          data,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container();
                          },
                        );
                      }
                    },
                    error: (e, t) {
                      return Container();
                      //return Image.network(url);
                    },
                    loading: () {
                      return Container();
                    },
                  ),
                ),
              ),
            ),
          ),
          if (!companyModel.description.isEmpty)
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "وصف:",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            companyModel.description,
                            wrapWords: false,
                            style: Theme.of(context).textTheme.bodyLarge,
                            //overflow: TextOverflow.fade,
                            //softWrap: false,
                            maxLines: 5,
                          ),
                        )
                      ],
                    ),
                    Gap(10),
                  ],
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "اسباب المقاطعة:",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 75,
                        color: Colors.black12,
                        child: Center(
                            child: TextButton.icon(
                                onPressed: () async {
                                  final Uri _url = Uri.parse(companyModel.resources[index].link);
                                  await launchUrl(_url);
                                },
                                icon: Icon(Icons.link),
                                label: Text(companyModel.resources[index].name))),
                      ),
                    ),
                childCount: companyModel.resources.length),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "البدائل:",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 75,
                        color: Colors.black12,
                        child: Center(
                            child: TextButton.icon(
                                onPressed: () async {
                                  final Uri _url = Uri.parse(companyModel.alternatives[index].link);
                                  await launchUrl(_url);
                                },
                                icon: Icon(Icons.link),
                                label: Text(companyModel.alternatives[index].name))),
                      ),
                    ),
                childCount: companyModel.alternatives.length),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 75,
                        //color: Colors.black12,
                      ),
                    ),
                childCount: 5),
          )
        ],
      ),
    );
  }
}
