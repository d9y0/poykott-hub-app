import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:boycott_hub/apps/boycottisraelitech/features/companies/states/cached_logo_provider.dart';
import 'package:boycott_hub/apps/boycottisraelitech/features/companies/states/companies_api_provider.dart';
import 'package:boycott_hub/apps/boycottisraelitech/route/app_routes.dart';
import 'package:boycott_hub/features/shared_states/search_state/search_state_provider.dart';

import 'package:boycott_hub/ui/widgets/layer_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:auto_size_text/auto_size_text.dart';

@RoutePage(
  name: HomeScreen.name,
)
class HomeScreen extends ConsumerStatefulWidget {
  static const name = "BoycottIsraeliTech_HomeScreenRoute";
  static const path = "/HomeScreen";
  const HomeScreen({super.key});
//ref.read(companiesApiProvider)
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(CompaniesStateProviders.companiesApiProvider.future),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: AutoSizeText(
                "قاطع المنتجات الإسرائيلية التقنية",
                softWrap: false,
                maxLines: 1,
              ),

              //Text("قاطع المنتجات الإسرائيلية التقنية"),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    AutoRouter.of(context).push(BoycottIsraeliTech_SettingsScreenRoute());
                  },
                ),
              ],

              centerTitle: true,
              floating: true,
              pinned: false,
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: [
                              TextSpan(
                                text: "مشروع مقاطعة المنتجات التقنية الإسرائيلية والداعمة لها وتوفير بدائلها. نرحب بالمساهمة في ",
                              ),
                              TextSpan(
                                text: 'مستودعنا على Github ',
                                style: TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()..onTap = () {},
                              ),
                              TextSpan(
                                text: "أو ساهم على",
                              ),
                              TextSpan(
                                text: 'Google Form.',
                                style: TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer(builder: (context, ref, child) {
                    if (!ref.watch(CompaniesStateProviders.companiesHasValueProvider)) {
                      return Container();
                    }
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                ref.read(searchStateProvider.notifier).state = value;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(22.0),
                                hintText: "البحث",
                                prefixIcon: Icon(Icons.search),
                                //suffix: IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt)),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      AutoRouter.of(context).push(BoycottIsraeliTech_SearchFiltersBottomSheetsRoute());
                                    },
                                    icon: Icon(Icons.filter_alt)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  Gap(20),
                ],
              ),
            ),
            Consumer(builder: (context, ref, child) {
              return ref.watch(CompaniesStateProviders.companiesSearchProvider).when(
                data: (models) {
                  return SliverList.builder(
                    //primary: false,
                    //controller: scrollController,
                    //shrinkWrap: true,

                    itemBuilder: (context, index) {
                      return InkWellLayerWidget(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          AutoRouter.of(context).push(BoycottIsraeliTech_DetailsScreenRoute(companyModel: models[index]));
                        },
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Row(
                          children: [
                            Consumer(builder: (context, ref2, child) {
                              return ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: ref2.watch(cachedLogoProvider(models[index].fixedLogo)).when(
                                    data: (data) {
                                      if (data == null) {
                                        return Container();
                                      }

                                      if (models[index].logoType == ".avif") {
                                        return AvifImage.file(
                                          data,
                                          width: 48,
                                          height: 48,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container();
                                          },
                                          fit: BoxFit.contain,
                                        );
                                      } else if (models[index].logoType == ".svg") {
                                        return SizedBox(
                                          width: 48,
                                          height: 48,
                                          child: SvgPicture(
                                            SvgStringLoader(data.readAsStringSync()),
                                            width: 48,
                                            height: 48,
                                            fit: BoxFit.contain,
                                            clipBehavior: Clip.none,
                                          ),
                                        );
                                      } else {
                                        return Image.file(
                                          data,
                                          width: 48,
                                          height: 48,
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container();
                                          },
                                        );
                                      }
                                    },
                                    error: (e, t) {
                                      return InkWell(
                                        onTap: () {},
                                        child: SizedBox(
                                          width: 48,
                                          height: 48,
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                      //return Image.network(url);
                                    },
                                    loading: () {
                                      return SizedBox(
                                        width: 48,
                                        height: 48,
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }),
                            Gap(10),

                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: AutoSizeText(
                                            models[index].name,
                                            wrapWords: true,
                                            style: Theme.of(context).textTheme.bodyLarge,
                                            maxLines: 1,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  if (models[index].description.isNotEmpty)
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: AutoSizeText(
                                              models[index].description,
                                              wrapWords: true,
                                              style: Theme.of(context).textTheme.bodySmall,
                                              overflow: TextOverflow.fade,
                                              softWrap: false,
                                              maxLines: 2,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  Gap(4),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 5, right: 5, bottom: 3),
                                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary, borderRadius: BorderRadius.circular(15)),
                                          child: Center(
                                            child: Text(models[index].arCategory),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_back_ios_new,
                              color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.3),
                            )

                            //CachedImageWidget(data[index].fixedLogo),
                          ],
                        ),
                      );
                    },
                    itemCount: models.length,
                  );
                },
                error: (e, stackTrace) {
                  return SliverToBoxAdapter(
                    child: Container(
                      child: Center(
                        child: Text("حدث خطأ تأكد من اتصالك بالانترنت"),
                      ),
                    ),
                  );
                },
                loading: () {
                  return SliverToBoxAdapter(
                    child: Container(
                      child: Center(
                        child: Text("يرجا الانتضار..."),
                      ),
                    ),
                  );
                },
              );
              //return SliverList.builder(itemBuilder: itemBuilder);
            }),
          ],
        ),
      ),
    );
  }
}
