//
//  UIView+Category.m
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/28.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "UIView+Category.h"
#import "UIView+EX.h"
#import "NSString+Category.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "NSString+Category.h"

@implementation UIView (Category)

- (UIImage *)imageForView {
    CGSize size = self.frame.size;
    UIGraphicsBeginImageContext(size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIView *)viewFromXib{
    UIView *targetView = [[[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    return targetView;
}

@end


@implementation UIView (MotionEffect)

NSString *const centerX = @"center.x";
NSString *const centerY = @"center.y";

#pragma mark - Motion Effect
- (void)addCenterMotionEffectsXYWithOffset:(CGFloat)offset {
    
    //    if(!IS_OS_7_OR_LATER) return;
    if(floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) return;
    
    UIInterpolatingMotionEffect *xAxis;
    UIInterpolatingMotionEffect *yAxis;
    
    xAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:centerX
                                                            type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xAxis.maximumRelativeValue = @(offset);
    xAxis.minimumRelativeValue = @(-offset);
    
    yAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:centerY
                                                            type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    yAxis.minimumRelativeValue = @(-offset);
    yAxis.maximumRelativeValue = @(offset);
    
    UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
    group.motionEffects = @[xAxis, yAxis];
    
    [self addMotionEffect:group];
}

@end


@implementation UIView (Shake)

- (void) shakeAnimation {
    
    CALayer* layer = [self layer];
    CGPoint position = [layer position];
    CGPoint y = CGPointMake(position.x - 3.0f, position.y);
    CGPoint x = CGPointMake(position.x + 3.0f, position.y);
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08f];
    [animation setRepeatCount:3];
    [layer addAnimation:animation forKey:nil];
}

@end



@implementation UIView (Screenshot)

- (UIImage *) screenshot {
    
    //UIGraphicsBeginImageContextWithOptions截图不清晰，
    //建议使用UIGraphicsBeginImageContextWithOptions
    UIGraphicsBeginImageContext(self.bounds.size);//截图不清晰
    //UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);//截图清晰
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //NSData *imageData = UIImagePNGRepresentation(image);//生成PNG格式，无法设置图片质量
    //生成JPG格式，参数二（范围：0.0 ~ 1.0）图片质量递增
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    image = [UIImage imageWithData:imageData];
    
    return image;
    
}


- (UIImage *) screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    //need to translate the context down to the current visible portion of the scrollview
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0f, -contentOffset.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.55);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

- (UIImage *) screenshotInFrame:(CGRect)frame {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), frame.origin.x, frame.origin.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

@end





static const CGFloat CSMaxWidthScale            = 0.8;  //最大宽度比例
static const CGFloat CSMaxHeightScale           = 0.8;  //最大高度比例
static const CGFloat CSHorizontalPadding        = 10.0; //横排间距
static const CGFloat CSVerticalPadding          = 10.0; //竖排间距
static const CGFloat CSFitPadding               = 60.0; //居上或居下的间距
static const CGFloat CSCornerRadius             = 5.0;  //显示图圆角大小
static const CGFloat CSOpacity                  = 0.8;  //不透明度
static const CGFloat CSFontSize                 = 16.0; //显示文字大小
static const CGFloat CSMaxTitleLines            = 0;    //标题最大显示行数（0表示可换行）
static const CGFloat CSMaxMessageLines          = 0;    //信息最大显示行数（0表示可换行）
static const CGFloat CSFadeDuration             = 0.2;  //消失时间
static const CGFloat CSDisplayDuration          = 2.0;  //默认显示时长
static const CGFloat CSShadowOpacity            = 0.8;  //阴影不透明度
static const CGFloat CSShadowRadius             = 2.0;  //阴影半径
static const CGFloat CSImageViewWidth           = 80.0; //设置图片的最大宽度
static const CGFloat CSImageViewHeight          = 80.0; //设置图片的最大高度
static const CGSize  CSShadowOffset             = { 2.0, 2.0 };  //阴影偏移量
static const BOOL    CSDisplayShadow            = YES;  //是否显示阴影（default：YES）
static const NSString * CSDefaultPosition       = @"center"; //默认显示在底部


#define TAG_OF_MESSAGE_VIEW             99990
#define TAG_OF_ERROR_VIEW               99991
#define TAG_OF_ERROR_LABEL              99992
static BOOL animationed = YES;

@implementation UIView (toost)

- (void)displayMessage:(NSString *)message {
    [self displayMessage:message duration:CSDisplayDuration position:CSDefaultPosition];
}

- (void)displayMessage:(NSString *)message duration:(CGFloat)interval position:(id)position {
    UIView *view = [self viewForMessage:message title:nil image:nil];
    [self displayView:view duration:interval position:position];
}

- (void)displayView:(UIView *)view duration:(CGFloat)interval position:(id)point {
    
    view.center = [self centerPointForPosition:point withSuperView:view];
    view.alpha = 0.0;
    //如果window上加了视图，就显示不出来，所以直接加到window上
//    [self addSubview:view];
    [UIApplication.sharedApplication.keyWindow addSubview:view];

    [UIView animateWithDuration:CSFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         view.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:CSFadeDuration
                                               delay:interval
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              view.alpha = 0.0;
                                          } completion:^(BOOL finished) {
                                              [view removeFromSuperview];
                                          }];
                     }];
}

- (CGPoint)centerPointForPosition:(id)point withSuperView:(UIView *)superView {
    
    if([point isKindOfClass:[NSString class]]) {
        
        if([point caseInsensitiveCompare:@"top"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (superView.frame.size.height / 2) + CSFitPadding);
        } else if([point caseInsensitiveCompare:@"bottom"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (superView.frame.size.height / 2)) - CSFitPadding);
        } else if([point caseInsensitiveCompare:@"center"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    return [self centerPointForPosition:CSDefaultPosition withSuperView:superView];
}

- (UIView *)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    
    if((message == nil) && (title == nil) && (image == nil)) return nil;
    
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    
    UIView *wrapperView = [self viewWithTag:TAG_OF_MESSAGE_VIEW];
    if (wrapperView == nil) {
        wrapperView = [[UIView alloc] init];
        wrapperView.tag = TAG_OF_MESSAGE_VIEW;
    }
    
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = CSCornerRadius;
    
    if (CSDisplayShadow) {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = CSShadowOpacity;
        wrapperView.layer.shadowRadius = CSShadowRadius;
        wrapperView.layer.shadowOffset = CSShadowOffset;
    }
    
    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:CSOpacity];
    
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(CSHorizontalPadding, CSVerticalPadding, CSImageViewWidth, CSImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    if(imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = CSHorizontalPadding;
    } else {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = CSMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:CSFontSize];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * CSMaxWidthScale) - imageWidth, self.bounds.size.height * CSMaxHeightScale);
        CGSize expectedSizeTitle = [title sizeWithConstrainedSize:maxSizeTitle font:titleLabel.font lineSpacing:0];
        //[title sizeWithFont:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = CSMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:CSFontSize];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * CSMaxWidthScale) - imageWidth, self.bounds.size.height * CSMaxHeightScale);
        CGSize expectedSizeMessage = [message sizeWithConstrainedSize:maxSizeMessage font:messageLabel.font lineSpacing:0];
        //[message sizeWithFont:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = CSVerticalPadding;
        titleLeft = imageLeft + imageWidth + CSHorizontalPadding;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;
    
    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + CSHorizontalPadding;
        messageTop = titleTop + titleHeight + CSVerticalPadding;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }
    
    
    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    CGFloat wrapperWidth = MAX((imageWidth + (CSHorizontalPadding * 2)), (longerLeft + longerWidth + CSHorizontalPadding));
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + CSVerticalPadding), (imageHeight + (CSVerticalPadding * 2)));
    
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
    
    return wrapperView;
}

/*----------------------------------------------------------------------------------------*/
- (void)displayError:(NSString *)error {
    if(error.length > 0){
        [SVProgressHUD setContainerView:self];
        [SVProgressHUD showInfoWithStatus:error];
        [SVProgressHUD dismissWithDelay:1.0];
        [SVProgressHUD setContainerView:nil];
    }
}

- (void)displayError:(NSString *)error duration:(CGFloat)interval {
    UIView *view = [self viewForError:error];
    [self displayErrorView:view duration:interval];
}

- (void)displayErrorView:(UIView *)errorView duration:(CGFloat)interval{
    
    if (!animationed) {
        return;
    }
    errorView.alpha = 0.0;
    [self addSubview:errorView];
    
    [UIView animateWithDuration:CSFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         animationed = NO;
                         errorView.top = 0;
                         errorView.alpha = 1.0;
                         NSLog(@"errorView.top = %.f",errorView.top);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:CSFadeDuration
                                               delay:interval
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              animationed = NO;
                                              errorView.bottom = 0.0f;
                                              errorView.alpha = 0.0;
                                              NSLog(@"errorView.top = %.f",errorView.top);
                                          } completion:^(BOOL finished) {
                                              [errorView removeFromSuperview];
                                              animationed = YES;
                                          }];
                     }];
}

- (UIView *)viewForError:(NSString *)error {

    if(error == nil || !animationed) return nil;
    
    UILabel *errorLabel = nil;
    
    UIView *wrapperView = [self viewWithTag:TAG_OF_ERROR_VIEW];
    if (wrapperView == nil) {
        wrapperView = [[UIView alloc] init];
        wrapperView.tag = TAG_OF_ERROR_VIEW;
    }
    wrapperView.backgroundColor = [UIColor lightGrayColor];
    
    CGSize errorSize = CGSizeZero;
    
    if (error != nil) {
        errorLabel = [[UILabel alloc] init];
        errorLabel.numberOfLines = CSMaxMessageLines;
        errorLabel.font = [UIFont systemFontOfSize:14.f];
        errorLabel.lineBreakMode = NSLineBreakByWordWrapping;
        errorLabel.textColor = [UIColor lightGrayColor];
        errorLabel.backgroundColor = [UIColor clearColor];
        errorLabel.alpha = 1.0;
        errorLabel.text = error;
        
        CGSize maxSizeError = CGSizeMake(self.bounds.size.width - 30, MAXFLOAT);
        errorSize = [error sizeWithConstrainedSize:maxSizeError font:errorLabel.font lineSpacing:0];
        errorLabel.frame = CGRectMake(0.0, 0.0, errorSize.width, errorSize.height);
    }
    
    CGFloat wrapperWidth = self.bounds.size.width;
    CGFloat wrapperHeight = MAX((MAX(errorSize.height, 20) + 10), 30);
    
    wrapperView.frame = CGRectMake(0.0, -64.f, wrapperWidth, wrapperHeight);
    
    CGFloat errorWidth, errorHeight, errorLeft, errorTop;
    
    if(errorLabel != nil) {
        errorWidth = errorLabel.bounds.size.width;
        errorHeight = errorLabel.bounds.size.height;
        errorLeft = 15.f;
        errorTop = (wrapperHeight - errorHeight) / 2;
    } else {
        errorWidth = errorHeight = errorLeft = errorTop = 0.0;
    }
    
    if(errorLabel != nil) {
        errorLabel.frame = CGRectMake(errorLeft, errorTop, errorWidth, errorHeight);
        [wrapperView addSubview:errorLabel];
    }
    
    return wrapperView;
}

@end
