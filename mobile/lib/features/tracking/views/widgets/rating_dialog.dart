import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobile/core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/generic_text_button.dart';
import '../../logic/rating_cubit/rating_cubit.dart';
import '../../logic/rating_cubit/rating_state.dart';

class RatingDialog extends StatefulWidget {
  final int requestId;
  final String token;

  const RatingDialog({
    super.key,
    required this.requestId,
    required this.token,
  });

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RatingCubit, RatingState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: ColorsManager.red),
              ),
            );
          },
          success: (data) {
            context.pop(); // remove loading
            context.pop(); // remove rating dialog
            // You can show a success snackbar or another dialog here
          },
          failure: (errMessage) {
            context.pop(); // remove loading
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errMessage)),
            );
          },
        );
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorsManager.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 40),
            ),
            verticalSpacing(24),
            Text(
              'Your Request Is Complete',
              style: TextStyles.font22BlackBold,
              textAlign: TextAlign.center,
            ),
            verticalSpacing(16),
            Text(
              "We'd Love Your Feedback. How\nSatisfied Are You With The\nService?",
              style: TextStyles.font16LightGrayWithOpacityMedium,
              textAlign: TextAlign.center,
            ),
            verticalSpacing(24),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating.toInt();
                });
              },
            ),
            verticalSpacing(24),
            GenericTextButton(
              buttonText: 'Submit',
              textStyle: TextStyles.font16WhiteBold,
              onPressed: () {
                if (_rating > 0) {
                  context.read<RatingCubit>().rateDriver(
                        token: widget.token,
                        id: widget.requestId,
                        rating: _rating,
                      );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a rating before submitting.'),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
