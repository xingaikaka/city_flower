import 'package:flutter/material.dart';
import '../data/city_flower_data.dart';
import '../models/city_flower.dart';
import '../theme/flower_theme.dart';
import '../widgets/flower_image.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();
  List<CityFlower> _results = cityFlowers;

  void _onChanged(String q) {
    setState(() => _results = searchFlowers(q));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlowerTheme.background,
      appBar: AppBar(
        backgroundColor: FlowerTheme.background,
        title: Text('搜索市花',
            style: FlowerTheme.serif(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 1)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 18, color: FlowerTheme.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _ctrl,
              autofocus: true,
              onChanged: _onChanged,
              decoration: InputDecoration(
                hintText: '搜索城市、花名、大区或花语…',
                prefixIcon: const Icon(Icons.search_rounded,
                    color: FlowerTheme.primary, size: 20),
                suffixIcon: _ctrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 18),
                        onPressed: () {
                          _ctrl.clear();
                          _onChanged('');
                        })
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                Text(
                  _ctrl.text.isEmpty
                      ? '共 ${_results.length} 座城市'
                      : '找到 ${_results.length} 条结果',
                  style: FlowerTheme.sans(
                      fontSize: 12, color: FlowerTheme.textSecondary),
                ),
              ],
            ),
          ),
          Expanded(
            child: _results.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🌸', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text('暂无匹配结果',
                            style: FlowerTheme.serif(
                                fontSize: 16,
                                color: FlowerTheme.textSecondary)),
                        const SizedBox(height: 6),
                        Text('试试搜索"梅花"或"上海"',
                            style: FlowerTheme.sans(
                                fontSize: 13,
                                color: FlowerTheme.textSecondary)),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (_, i) => _SearchCard(flower: _results[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _SearchCard extends StatelessWidget {
  final CityFlower flower;
  const _SearchCard({required this.flower});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => DetailScreen(flower: flower))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: FlowerTheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: FlowerTheme.divider),
        ),
        child: Row(
          children: [
            FlowerImage(
              flower: flower,
              width: 80,
              height: 80,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(flower.cityName,
                            style: FlowerTheme.serif(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(width: 6),
                        Text('${flower.emoji} ${flower.flowerName}',
                            style: FlowerTheme.sans(
                                fontSize: 13, color: flower.accentColor,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(flower.meaning,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FlowerTheme.sans(
                            fontSize: 12, color: FlowerTheme.textSecondary)),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.chevron_right_rounded,
                  size: 18, color: FlowerTheme.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
