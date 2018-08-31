//
//  KKErrorView.h
//  KuarkPay
//
//  Created by john on 2017/11/9.
//  Copyright © 2017年 john. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KKErrorViewDelegate<NSObject>

@optional
- (CGFloat)errorTitleOffset;

@end

///错误页
@interface KKErrorView : UIView

@property (nonatomic, weak) id<KKErrorViewDelegate>delegate;
@property (nonatomic, strong, readonly) UIButton *errorIconView;
@property (nonatomic, strong, readonly) UILabel *errorTitleLabel;
@property (nonatomic, strong, readonly) UILabel *errorSubTitleLabel;
@property (nonatomic, strong, readonly) UIButton *errorRetryButton;

@property (nonatomic, copy) void(^errorRetryAction)(void);

@property (nonatomic, copy) NSString *errImageIcon;
//提示消息
@property (nonatomic, copy) NSString *errTitle;
@property (nonatomic, copy) NSAttributedString *errAttrTitle;
//提示消息
@property (nonatomic, copy) NSString *errSubTitle;
@property (nonatomic, copy) NSAttributedString *errSubAttrTitle;
//
@property (nonatomic, copy) NSString *errMsg;
@property (nonatomic, copy) NSAttributedString *errAttrMsg;

//重试标题
@property (nonatomic, copy) NSString *errRetryButtonTitle;
@property (nonatomic, copy) NSAttributedString *errRetryButtonAttrTitle;

/**
 偏移位置,默认0
 */
@property (nonatomic, assign) CGFloat errViewOffsetY;

@end

///无数据
@interface EmptyErrorView:KKErrorView

- (instancetype)initWithErrorIcon:(NSString *)errorIcon errorTitle:(NSString *)errorTitle subTitle:(NSString *)subTitle retryBtnTitle:(NSString *)retryBtnTitle frame:(CGRect)frame;

@end
///无网络
@interface OfflineErrorView:KKErrorView

@end
///请求失败
@interface RequestErrorView:KKErrorView


@end
