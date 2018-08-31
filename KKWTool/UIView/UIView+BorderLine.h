//
//  UIView+BorderLine.h
//  ZSEthersWallet
//
//  Created by thomasho on 2018/1/4.
//  Copyright © 2018年 lkl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ShowLineType) {
    ShowLineType_Top,     //上
    ShowLineType_Left,    //左
    ShowLineType_Bottom,  //下
    ShowLineType_Right,   //右
};

@interface UIView (BorderLine)

- (void)setShowLineType:(ShowLineType)type;

/**
 截圆角 : 使用该方法的视图需要先设置好frame不然会导致该方法无效
 */
- (CALayer *)maskWithCorners:(UIRectCorner)corners cornerRadii:(CGFloat)cornerRadii maskColor:(UIColor *)maskColor;

/**
 描边
 */
- (CALayer *)applyBorderRadius:(CGFloat)borderRadius borderColor:(UIColor *)borderColor;

- (CALayer *)applyBorderRadius:(CGFloat)borderRadius borderColor:(UIColor *)borderColor fillColor:(UIColor *)fillColor;

- (CALayer *)applyBorderRadius:(CGFloat)borderRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth fillColor:(UIColor *)fillColor;


@end
