import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/helpers/extensions.dart';
import 'package:mobile/core/theming/colors.dart';
import 'package:mobile/features/requests/data/models/requests/requests_response_model.dart';
import 'package:mobile/features/requests/logic/cancel_cubit/cancel_cubit.dart';
import 'package:mobile/features/requests/logic/confirm_cubit/confirm_cubit.dart';
import 'package:mobile/features/requests/logic/reject_cubit/reject_cubit.dart';
import 'package:mobile/features/requests/views/widgets/cancel_bloc_listener.dart';
import 'package:mobile/features/requests/views/widgets/confirm_bloc_listener.dart';
import 'package:mobile/features/requests/views/widgets/reject_bloc_listener.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/generic_text_button.dart';

class RequestWidget extends StatelessWidget {
  final Request request;
  final String token;
  final bool isDriver;

  const RequestWidget({
    super.key,
    required this.request,
    required this.token,
    required this.isDriver,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (request.status == 'in_progress') {
          context.pushNamed(
            Routes.trackingView,
            arguments: {
              'id': request.id,
              'token': token,
              'isDriver': isDriver,
              'request': request,
            },
          );
        }
      },
      child: Container(
        width: 370.w,
        height: 172.h,
        margin: EdgeInsets.only(bottom: 16.h, left: 30.w, right: 30.w),
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
                        request.requestType == 'emergency'
                            ? 'SOS'
                            : 'Scheduled',
                        style: request.requestType == 'emergency'
                            ? TextStyles.font16RedBold
                            : TextStyles.font16BlackBold,
                      ),
                    ],
                  ),
                  !isDriver
                      ? Container(
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
                            style:
                                request.status == 'pending' ||
                                    request.status == 'in_progress'
                                ? TextStyles.font16BlackRegular
                                : TextStyles.font16BlackRegular.copyWith(
                                    color: Colors.white,
                                  ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            verticalSpacing(16),
            Text(
              '7 Port Said St., Near Mansoura Stadium',
              style: TextStyles.font16BlackBold,
            ),
            verticalSpacing(8),
            Text(
              '${request.createdAt?.split(' ').first}        ${request.createdAt?.split(' ').last}',
              style: TextStyles.font16LightGrayWithOpacityMedium.copyWith(
                height: 1.5,
              ),
            ),
            verticalSpacing(16),
            Row(
              mainAxisAlignment: isDriver ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: request.status == 'pending' && isDriver,
                  child: GenericTextButton(
                    buttonText: 'Confirm',
                    textStyle: TextStyles.font16WhiteBold,
                    buttonWidth: 120.w,
                    buttonHeight: 42.h,
                    borderRadius: 16.r,
                    onPressed: () {
                      context.read<ConfirmCubit>().emitConfirmState(
                        token: token,
                        id: request.id!,
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: request.status == 'pending',
                  child: GenericTextButton(
                    buttonText: 'Cancel',
                    textStyle: isDriver ? TextStyles.font16RedBold : TextStyles.font16WhiteBold,
                    buttonWidth: 120.w,
                    buttonHeight: 42.h,
                    borderRadius: 16.r,
                    isHaveBorder: isDriver,
                    backgroundColor: isDriver
                        ? Colors.white
                        : ColorsManager.red,
                    onPressed: () {
                      !isDriver
                          ? context.read<CancelCubit>().emitCancelState(
                              token: token,
                              id: request.id!,
                            )
                          : context.read<RejectCubit>().emitRejectState(
                              token: token,
                              id: request.id!,
                            );
                    },
                  ),
                ),
              ],
            ),
            isDriver ? const SizedBox.shrink() : const CancelBlocListener(),
            if (isDriver) const ConfirmBlocListener(),
            if (isDriver) const RejectBlocListener(),
          ],
        ),
      ),
    );
  }
}
