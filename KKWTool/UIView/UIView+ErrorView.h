//
//  UIView+ErrorView.h
//  Kuoke
//
//  Created by john on 2017/12/8.
//  Copyright © 2017年 john. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKErrorView.h"

typedef NS_ENUM(NSInteger,KKErrorViewType) {
    /**正常状态*/
    KKErrorViewTypeNone,
    /**空页面*/
    KKErrorViewTypeEmpty,
    KKErrorViewTypeEmptyDarkBackground,
    /**无网络*/
    KKErrorViewTypeOffline,
    /**请求错误*/
    KKErrorViewTypeRequestError,
    /**无搜索结果*/
    KKErrorViewTypeNoSearchResult
};

@interface UIView (ErrorView)

@property (nonatomic, strong, readonly) KKErrorView *errorView;


- (void)showErrorViewWithTitle:(NSString *)errTitle errSubTitle:(NSString *)errSubTitle retryButtonTitle:(NSString *)retryButtonTitle errorViewType:(KKErrorViewType)errorViewType;

- (void)showErrorWithIcon:(NSString *)icon;

- (void)showErrorWithIcon:(NSString *)icon errorTitle:(NSString *)errorTitle;

- (void)hideErrorView;

@end
