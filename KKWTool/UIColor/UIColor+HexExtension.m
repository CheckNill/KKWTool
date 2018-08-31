//
//  UIColor+HexExtension.m
//  ZSEthersWallet
//
//  Created by thomasho on 2017/12/28.
//  Copyright © 2016年 lkl. All rights reserved.
//

#import "UIColor+HexExtension.h"

@implementation UIColor (HexExtension)

+ (instancetype)colorWithHexString:(NSString *)hexColor alpha:(CGFloat)alpha{
    unsigned int red,green,blue;
    NSRange range;
    
    range.length = 2;
    range.location = 1;
    NSString *_hexColor = hexColor;
    if(![_hexColor hasPrefix:@"#"]){
        _hexColor = [NSString stringWithFormat:@"#%@",_hexColor];
    }

    [[NSScanner scannerWithString:[_hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 3;
    [[NSScanner scannerWithString:[_hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 5;
    [[NSScanner scannerWithString:[_hexColor substringWithRange:range]]scanHexInt:&blue];
    
    UIColor* retColor = [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:alpha];
    
    return retColor;

}

+ (UIColor *)colorWithHexString:(NSString*) hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    NSString *_hexColor = hexColor;
    if(![_hexColor hasPrefix:@"#"]){
        _hexColor = [NSString stringWithFormat:@"#%@",_hexColor];
    }
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[_hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 3;
    [[NSScanner scannerWithString:[_hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 5;
    [[NSScanner scannerWithString:[_hexColor substringWithRange:range]]scanHexInt:&blue];
    
    UIColor* retColor = [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
    return retColor;
}
@end
