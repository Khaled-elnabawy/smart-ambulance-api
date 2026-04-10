import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/features/requests/data/models/requests/requests_response_model.dart';
import 'package:mobile/features/requests/logic/cancel_cubit/cancel_cubit.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/generic_text_button.dart';

class RequestWidget extends StatelessWidget {
  final Request request;
  final String token;

  const RequestWidget({super.key, required this.request, required this.token});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370.w,
      height: 172.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            offset: Offset(0, 6),
            spreadRadius: 0,
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 264.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      request.requestType == 'emergency'
                          ? 'assets/images/sos_request_icon_image.png'
                          : 'assets/images/scheduled_request_icon_image.png',
                      width: 38.w,
                      height: 32.h,
                    ),
                    horizontalSpacing(4),
                    Text(
                      request.requestType == 'emergency' ? 'SOS' : 'Scheduled',
                      style: request.requestType == 'emergency'
                          ? TextStyles.font16RedBold
                          : TextStyles.font16BlackBold,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: request.status == 'pending'
                        ? Color(0xffFBDE80)
                        : request.status == 'in_progress'
                        ? Color(0xffF7DADA)
                        : Color(0xff319F43).withValues(alpha: .8),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    request.status == 'pending'
                        ? 'Pending'
                        : request.status == 'in_progress'
                        ? 'In Progress'
                        : 'Completed',
                    style: request.status == 'pending' ||
                        request.status == 'in_progress'
                        ? TextStyles.font16BlackRegular
                        : TextStyles.font16BlackRegular.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          verticalSpacing(16),
          Text(
            '8/4/2026         1:15 AM',
            style: TextStyles.font16LightGrayWithOpacityMedium.copyWith(
              height: 1.5,
            ),
          ),
          verticalSpacing(16),
          Visibility(
            visible: request.status == 'pending',
            child: SizedBox(
              width: 80.w,
              child: GenericTextButton(
                buttonText: 'Cancel',
                textStyle: TextStyles.font16WhiteBold,
                buttonHeight: 42.h,
                borderRadius: 16.r,
                onPressed: () {
                  context.read<CancelCubit>().emitCancelState(
                      token: token, id: request.id!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
