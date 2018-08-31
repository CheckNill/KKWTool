//
//  UIView+ErrorView.m
//  Kuoke
//
//  Created by john on 2017/12/8.
//  Copyright © 2017年 john. All rights reserved.
//

#import "UIView+ErrorView.h"
#import <objc/runtime.h>

const NSString *KKErrorViewKey = @"com.john.errview";

@interface UIView()<KKErrorViewDelegate>

@property (nonatomic, strong) KKErrorView *errorView;

@end

@implementation UIView (ErrorView)

- (KKErrorView *)errorView{
    EmptyErrorView *errorView = objc_getAssociatedObject(self, CFBridgingRetain(KKErrorViewKey));
    if(!errorView){
        errorView = [[EmptyErrorView alloc] initWithErrorIcon:@"empty2" errorTitle:nil subTitle:nil retryBtnTitle:nil frame:self.bounds];
        [self setErrorView:errorView];
    }
    return errorView;
}

- (void)setErrorView:(UIView *)errorView{
    objc_setAssociatedObject(self, CFBridgingRetain(KKErrorViewKey), errorView, OBJC_ASSOCIATION_RETAIN);
}

- (void)showErrorViewWithTitle:(NSString *)errTitle errSubTitle:(NSString *)errSubTitle retryButtonTitle:(NSString *)retryButtonTitle errorViewType:(KKErrorViewType)errorViewType{
    
    NSString *errorIcon = @"empty2";
    if(errorViewType == KKErrorViewTypeNoSearchResult){
        errorIcon = @"illustration_emptystate";
        self.errorView.delegate = self;
    }else if(errorViewType == KKErrorViewTypeEmpty || errorViewType == KKErrorViewTypeEmptyDarkBackground){
        errorIcon = @"empty2";
        self.errorView.delegate = nil;
    }
    
    self.errorView.errTitle = errTitle;
    self.errorView.errSubTitle = errSubTitle;
    self.errorView.errRetryButtonTitle = retryButtonTitle;
    
    if(errorViewType == KKErrorViewTypeEmptyDarkBackground){
        self.errorView.errorTitleLabel.textColor = [UIColor whiteColor];
    }else{
        
    }
    self.errorView.errImageIcon = errorIcon;
    if(![self.subviews containsObject:self.errorView]){
        [self addSubview:self.errorView];
    }
}

- (void)showErrorWithIcon:(NSString *)icon{
    
    NSString *errorIcon = icon ?: @"wallet_initial_icon";
    
    self.errorView.errImageIcon = errorIcon;
    if(![self.subviews containsObject:self.errorView]){
        [self addSubview:self.errorView];
    }
}

- (void)showErrorWithIcon:(NSString *)icon errorTitle:(NSString *)errorTitle{
    NSString *errorIcon = icon ?: @"wallet_initial_icon";
    
    self.errorView.errImageIcon = errorIcon;
    self.errorView.errTitle = errorTitle;
    if(![self.subviews containsObject:self.errorView]){
        [self addSubview:self.errorView];
    }
}

- (void)hideErrorView{
    [self.errorView removeFromSuperview];
}

- (CGFloat)errorTitleOffset{
    return 10;
}

@end
