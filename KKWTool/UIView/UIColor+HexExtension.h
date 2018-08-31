//
//  UIColor+HexExtension.h
//  ZSEthersWallet
//
//  Created by thomasho on 2017/12/28.
//  Copyright © 2016年 lkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexExtension)

+ (instancetype)colorWithHexString:(NSString *)hexColor alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString*) hexColor;

@end
