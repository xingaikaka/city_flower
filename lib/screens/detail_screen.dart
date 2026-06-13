import 'package:flutter/material.dart';
import '../models/city_flower.dart';
import '../theme/flower_theme.dart';
import '../widgets/flower_image.dart';

class DetailScreen extends StatelessWidget {
  final CityFlower flower;
  const DetailScreen({super.key, required this.flower});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlowerTheme.background,
      body: CustomScrollView(
        slivers: [
          // ── 大图 AppBar ──
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: FlowerTheme.background,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: 18, color: FlowerTheme.textPrimary),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: FlowerImage(
                flower: flower,
                borderRadius: BorderRadius.zero,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ── 内容 ──
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 城市 + 花名 标题
                Container(
                  width: double.infinity,
                  color: FlowerTheme.surface,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(flower.cityName,
                              style: FlowerTheme.serif(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: FlowerTheme.textPrimary)),
                          const SizedBox(width: 8),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(flower.province,
                                style: FlowerTheme.sans(
                                    fontSize: 13,
                                    color: FlowerTheme.textSecondary)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(flower.emoji,
                              style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 6),
                          Text(flower.flowerName,
                              style: FlowerTheme.serif(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: flower.accentColor)),
                          const SizedBox(width: 8),
                          Text('· ${flower.flowerAlias}',
                              style: FlowerTheme.sans(
                                  fontSize: 13,
                                  color: FlowerTheme.textSecondary)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        flower.latinName,
                        style: FlowerTheme.sans(
                            fontSize: 12,
                            color: FlowerTheme.textSecondary,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // 基本信息卡
                _InfoCard(children: [
                  _InfoRow(icon: Icons.calendar_today_rounded,
                      label: '确定时间', value: flower.designatedDate),
                  _InfoRow(icon: Icons.palette_rounded,
                      label: '花色', value: flower.flowerColor),
                  _InfoRow(icon: Icons.local_florist_rounded,
                      label: '花期', value: flower.bloomSeason),
                  _InfoRow(icon: Icons.favorite_rounded,
                      label: '花语', value: flower.meaning),
                ]),

                const SizedBox(height: 8),

                // 历史渊源
                _ContentSection(
                  icon: Icons.history_edu_rounded,
                  title: '历史渊源',
                  accentColor: flower.accentColor,
                  content: flower.history,
                ),

                const SizedBox(height: 8),

                // 确定原因
                _ContentSection(
                  icon: Icons.star_rounded,
                  title: '确定为市花的原因',
                  accentColor: flower.accentColor,
                  content: flower.reason,
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: FlowerTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: FlowerTheme.divider),
      ),
      child: Column(
        children: List.generate(children.length * 2 - 1, (i) {
          if (i.isOdd) return Divider(color: FlowerTheme.divider, height: 16);
          return children[i ~/ 2];
        }),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: FlowerTheme.primary),
        const SizedBox(width: 8),
        Text('$label：',
            style: FlowerTheme.sans(
                fontSize: 13, color: FlowerTheme.textSecondary)),
        Expanded(
          child: Text(value,
              style: FlowerTheme.sans(
                  fontSize: 13,
                  color: FlowerTheme.textPrimary,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}

class _ContentSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color accentColor;
  final String content;
  const _ContentSection({
    required this.icon,
    required this.title,
    required this.accentColor,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FlowerTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: FlowerTheme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: accentColor),
              const SizedBox(width: 6),
              Text(title,
                  style: FlowerTheme.serif(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: FlowerTheme.textPrimary)),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: accentColor, width: 2)),
            ),
            child: Text(
              content,
              style: FlowerTheme.sans(
                  fontSize: 14,
                  color: FlowerTheme.textPrimary,
                  height: 1.8),
            ),
          ),
        ],
      ),
    );
  }
}
