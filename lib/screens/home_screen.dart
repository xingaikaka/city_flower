import 'package:flutter/material.dart';
import '../data/city_flower_data.dart';
import '../models/city_flower.dart';
import '../theme/flower_theme.dart';
import '../widgets/flower_image.dart';
import 'detail_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedProvince = '全部';

  List<CityFlower> get _filtered => flowersByProvince(_selectedProvince);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlowerTheme.background,
      body: CustomScrollView(
        slivers: [
          // ── 顶部 AppBar ──
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: FlowerTheme.background,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, e, st) => Container(
                          width: 64, height: 64,
                          decoration: BoxDecoration(
                            color: FlowerTheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(child: Text('🌸', style: TextStyle(fontSize: 32))),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('花城志',
                            style: FlowerTheme.serif(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: FlowerTheme.primary,
                              letterSpacing: 4,
                            )),
                        const SizedBox(height: 3),
                        Text('中国城市市花图鉴',
                            style: FlowerTheme.sans(
                              fontSize: 12,
                              color: FlowerTheme.textSecondary,
                              letterSpacing: 1,
                            )),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (_) => const SearchScreen())),
                      icon: const Icon(Icons.search_rounded),
                      color: FlowerTheme.textPrimary,
                    ),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Divider(color: FlowerTheme.divider, height: 1),
            ),
          ),

          // ── 统计信息 ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  _StatBadge(label: '城市', value: '${cityFlowers.length}'),
                  const SizedBox(width: 12),
                  _StatBadge(label: '花种', value: '${cityFlowers.map((e) => e.flowerName).toSet().length}'),
                  const SizedBox(width: 12),
                  _StatBadge(label: '大区', value: '${provinces.length - 1}'),
                ],
              ),
            ),
          ),

          // ── 省区筛选 ──
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: provinces.length,
                separatorBuilder: (_, idx) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final p = provinces[i];
                  final selected = p == _selectedProvince;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedProvince = p),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? FlowerTheme.primary : FlowerTheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selected ? FlowerTheme.primary : FlowerTheme.divider,
                        ),
                      ),
                      child: Text(
                        p,
                        style: FlowerTheme.sans(
                          fontSize: 13,
                          color: selected ? Colors.white : FlowerTheme.textSecondary,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ── 分区标题 ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Row(
                children: [
                  Container(
                    width: 3,
                    height: 16,
                    decoration: BoxDecoration(
                      color: FlowerTheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _selectedProvince == '全部' ? '全部城市' : '$_selectedProvince · ${_filtered.length} 座城市',
                    style: FlowerTheme.serif(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: FlowerTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── 城市卡片列表 ──
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => _CityCard(flower: _filtered[i]),
              childCount: _filtered.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final String value;
  const _StatBadge({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: FlowerTheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: FlowerTheme.primary.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value,
              style: FlowerTheme.serif(
                  fontSize: 16, fontWeight: FontWeight.w700, color: FlowerTheme.primary)),
          const SizedBox(width: 4),
          Text(label,
              style: FlowerTheme.sans(fontSize: 12, color: FlowerTheme.textSecondary)),
        ],
      ),
    );
  }
}

class _CityCard extends StatelessWidget {
  final CityFlower flower;
  const _CityCard({required this.flower});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => DetailScreen(flower: flower))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: FlowerTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: FlowerTheme.divider),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 图片
            FlowerImage(
              flower: flower,
              width: 100,
              height: 100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            // 文字
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(flower.cityName,
                            style: FlowerTheme.serif(
                                fontSize: 17,
                                fontWeight: FontWeight.w700)),
                        const SizedBox(width: 6),
                        Text(flower.emoji,
                            style: const TextStyle(fontSize: 14)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: flower.accentColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            flower.province,
                            style: FlowerTheme.sans(
                                fontSize: 11,
                                color: flower.accentColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      flower.flowerName,
                      style: FlowerTheme.serif(
                          fontSize: 14,
                          color: flower.accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${flower.bloomSeason} · ${flower.designatedYear}年定为市花',
                      style: FlowerTheme.sans(
                          fontSize: 12, color: FlowerTheme.textSecondary),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      flower.meaning,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FlowerTheme.sans(
                          fontSize: 12,
                          color: FlowerTheme.textSecondary,
                          height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.chevron_right_rounded,
                  color: FlowerTheme.textSecondary, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
