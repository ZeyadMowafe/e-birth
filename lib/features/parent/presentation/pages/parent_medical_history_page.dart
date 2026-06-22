import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/parent_medical_history_cubit.dart';
import '../cubit/parent_medical_history_state.dart';
import '../widgets/medical_history_list.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ebirth/l10n/app_localizations.dart';

class ParentMedicalHistoryPage extends StatelessWidget {
  const ParentMedicalHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF111827),
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Text(
            l10n.medicalHistoryTitle,
            style: GoogleFonts.readexPro(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF111827),
            ),
          ),
        ),
      ),
      body: BlocBuilder<ParentMedicalHistoryCubit, ParentMedicalHistoryState>(
        builder: (context, state) {
          if (state is ParentMedicalHistoryLoading) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ...List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: const ShimmerLoading.rectangular(height: 200),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ParentMedicalHistoryError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.readexPro(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Re-fetch logic can be added here if needed
                      },
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ParentMedicalHistoryLoaded) {
            if (state.histories.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.medical_services_outlined,
                      size: 64,
                      color: Color(0xFF9CA3AF),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.medicalHistoryEmpty,
                      style: GoogleFonts.readexPro(
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MedicalHistoryList(
                histories: state.histories,
                isChild: false,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
