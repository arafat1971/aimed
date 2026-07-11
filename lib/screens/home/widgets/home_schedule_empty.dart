import 'package:flutter/material.dart';

import '../../../core/constants/premium_graphics.dart';
import '../../../core/utils/haptic_engine.dart';
import '../../../core/utils/manual_add_medicine.dart';
import '../../../theme/med_ai_ui.dart';
import '../../../widgets/common/animated_pressable.dart';
import '../../../widgets/common/premium_illustration_banner.dart';
import '../../../widgets/common/premium_texture.dart';

class HomeScheduleEmpty extends StatelessWidget {
  final bool hasMeds;
  final VoidCallback? onAdd;

  const HomeScheduleEmpty({
    super.key,
    required this.hasMeds,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final L = context.L;
    final title =
        hasMeds ? 'Nothing scheduled today' : 'Add your first medicine';
    final subtitle = hasMeds
        ? 'No doses are set for this day. Check another date or edit your schedule.'
        : 'Scan or add a medicine to build your daily schedule.';

    return PremiumTextureCard(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      radius: 22,
      texture: PremiumTextureStyle.fineGrain,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumIllustrationBanner(
            asset: hasMeds
                ? PremiumGraphics.healthInsights
                : PremiumGraphics.onboardingDiagnose,
            height: 100,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
          ),
          Text(
            title,
            style: AppTypography.titleMedium.copyWith(
              color: L.text,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: AppTypography.bodySmall.copyWith(
              color: L.sub,
              height: 1.4,
            ),
          ),
          if (!hasMeds && onAdd != null) ...[
            const SizedBox(height: 14),
            AnimatedPressable(
              onTap: () {
                HapticEngine.selection();
                onAdd!();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: L.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Scan a medicine',
                  style: AppTypography.labelMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            AnimatedPressable(
              onTap: () =>
                  startManualAddMedicine(context, source: 'home_empty'),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  'Or enter it manually',
                  style: AppTypography.labelMedium.copyWith(
                    color: L.sub,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
