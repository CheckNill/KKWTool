//
//  KKErrorView.m
//  KuarkPay
//
//  Created by john on 2017/11/9.
//  Copyright © 2017年 john. All rights reserved.
//

#import "KKErrorView.h"
#import "UIView+EX.h"
#import "UIColor+StyleSheet.h"

#define KKWTool_STR(key, comment) NSLocalizedStringFromTable(key, @"KKWNetworkinging", comment)
#define Tool_ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface KKErrorView()

@property (nonatomic, strong) UIButton *errorIconView;
@property (nonatomic, strong) UILabel *errorTitleLabel;
@property (nonatomic, strong) UILabel *errorSubTitleLabel;
@property (nonatomic, strong) UIButton *errorRetryButton;

- (CGRect)errorIconFrame;
- (CGRect)errorDesLabelFrame;
- (CGRect)errorRetryButtonFrame;

@end

@implementation KKErrorView

- (instancetype)initWithFrame:(CGRect)frame{
    
    CGRect viewFrame = CGRectEqualToRect(frame, CGRectZero) ? CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds),300):CGRectMake(0, 0, CGRectGetWidth(frame),300);
    
    self = [super initWithFrame:viewFrame];
    if(self){
        self.errorIconView = [[UIButton alloc] init];
        [self.errorIconView setImage:[UIImage imageNamed:@"empty2"] forState:UIControlStateNormal] ;
        [self addSubview:self.errorIconView];
        
        self.errorTitleLabel = [[UILabel alloc] init];
        self.errorTitleLabel.font = [UIFont systemFontOfSize:11.0];
        self.errorTitleLabel.textColor = [UIColor kkLightGrayColor];
        self.errorTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.errorTitleLabel];
        
        self.errorSubTitleLabel = [[UILabel alloc] init];
        self.errorSubTitleLabel.numberOfLines = 3;
        self.errorSubTitleLabel.font = [UIFont systemFontOfSize:10.0];
        self.errorSubTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.errorSubTitleLabel.textColor = [UIColor kkDarkGrayColor];
        [self addSubview:self.errorSubTitleLabel];

        self.errorRetryButton = [[UIButton alloc] init];
        self.errorRetryButton.backgroundColor = [UIColor kkBlueColor];
        self.errorRetryButton.layer.cornerRadius = 5.0;
        self.errorRetryButton.hidden = YES;
        [self addSubview:self.errorRetryButton];
        [self.errorRetryButton addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setErrImageIcon:(NSString *)errImageIcon{
    [self.errorIconView setImage:[UIImage imageNamed:errImageIcon] forState:UIControlStateNormal];
}
- (void)setErrTitle:(NSString *)errTitle{
    self.errorTitleLabel.text = errTitle;
}

- (void)setErrAttrTitle:(NSAttributedString *)errAttrTitle{
    self.errorTitleLabel.attributedText = errAttrTitle;
}

- (void)setErrSubTitle:(NSString *)errSubTitle{
    self.errorSubTitleLabel.text = errSubTitle;
}

- (void)setErrSubAttrTitle:(NSAttributedString *)errSubAttrTitle{
    self.errorSubTitleLabel.attributedText = errSubAttrTitle;
}

- (void)setErrRetryButtonTitle:(NSString *)errRetryButtonTitle{
    [self.errorRetryButton setTitle:errRetryButtonTitle forState:UIControlStateNormal];
}

- (void)setErrRetryButtonAttrTitle:(NSAttributedString *)errRetryButtonAttrTitle{
    [self.errorRetryButton setAttributedTitle:errRetryButtonAttrTitle forState:UIControlStateNormal];
}

- (void)retry{
    if(self.errorRetryAction){
        self.errorRetryAction();
    }
}

- (void)setErrViewOffsetY:(CGFloat)errViewOffsetY{
    _errViewOffsetY = errViewOffsetY;
    CGRect errViewFrame = self.frame;
    errViewFrame.origin.y = _errViewOffsetY;
    self.frame = errViewFrame;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    UIView *__block lastView = nil;

    CGFloat imageWidth = CGImageGetWidth([self.errorIconView imageForState:UIControlStateNormal].CGImage)/[UIScreen mainScreen].scale;
    CGFloat imageHeiht = CGImageGetHeight([self.errorIconView imageForState:UIControlStateNormal].CGImage)/[UIScreen mainScreen].scale;
    self.errorIconView.frame = CGRectMake((self.width-imageWidth)/2.0, 136, imageWidth, imageHeiht);
    lastView = self.errorIconView;
    
    self.errorTitleLabel.hidden = self.errorTitleLabel.text.length == 0 && self.errorTitleLabel.attributedText.length == 0;
    if(!self.errorTitleLabel.hidden){
        CGFloat offset = 0.0;
        if(self.delegate && [self.delegate respondsToSelector:@selector(errorTitleOffset)]){
            offset = [self.delegate errorTitleOffset];
        }else{
            offset = [self getOffsetYOfLastView:lastView];
        }
        self.errorTitleLabel.frame = CGRectMake(0, CGRectGetMaxY(lastView.frame)+offset, Tool_ScreenWidth, self.errorTitleLabel.font.pointSize+1);
        lastView = self.errorTitleLabel;
    }
    
    self.errorSubTitleLabel.hidden = self.errorSubTitleLabel.text.length == 0 && self.errorSubTitleLabel.attributedText.length == 0;
    if(!self.errorSubTitleLabel.hidden){
        CGFloat titleHeight = 0;
        if(self.errorSubTitleLabel.attributedText > 0){
            titleHeight = [self.errorSubTitleLabel.attributedText boundingRectWithSize:CGSizeMake(Tool_ScreenWidth,[self getFontSizeOfAttributedText:self.errorSubTitleLabel.attributedText]+1) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        }else if (self.errorSubTitleLabel.text.length > 0) {
            titleHeight = [self.errorSubTitleLabel.text boundingRectWithSize:CGSizeMake(Tool_ScreenWidth,self.errorSubTitleLabel.font.pointSize*3) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.errorSubTitleLabel.font} context:nil].size.height;;
        }
        self.errorSubTitleLabel.frame = CGRectMake(0, CGRectGetMaxY(lastView.frame)+[self getOffsetYOfLastView:lastView], Tool_ScreenWidth, titleHeight+1);
        lastView = self.errorSubTitleLabel;
    }
    
    NSString *buttonTitle = [self.errorRetryButton titleForState:UIControlStateNormal];
    NSAttributedString *buttonAttributedTitle = [self.errorRetryButton attributedTitleForState:UIControlStateNormal];
    self.errorRetryButton.hidden = buttonTitle.length == 0 && buttonAttributedTitle.length == 0;
    if(!self.errorSubTitleLabel.hidden){
        CGFloat titleWidth = 0;
        if(buttonAttributedTitle > 0){
            titleWidth = [buttonAttributedTitle boundingRectWithSize:CGSizeMake(Tool_ScreenWidth,self.errorRetryButton.titleLabel.font.pointSize) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;
        }else if (buttonTitle.length > 0) {
            titleWidth = [buttonTitle boundingRectWithSize:CGSizeMake(Tool_ScreenWidth,self.errorRetryButton.titleLabel.font.pointSize+1) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.errorRetryButton.titleLabel.font} context:nil].size.width;;
        }
        self.errorRetryButton.frame = CGRectMake((Tool_ScreenWidth-titleWidth)/2.0, CGRectGetMaxY(lastView.frame)+[self getOffsetYOfLastView:lastView], titleWidth, 35);
    }
}

- (CGFloat)getOffsetYOfLastView:(UIView *)lastView{
    if(!lastView){
        return 40;
    }
    if([lastView isKindOfClass:[UIImageView class]]){
        return 25;
    }else if ([lastView isKindOfClass:[UILabel class]]){
        UILabel *lastLabel = (UILabel *)lastView;
        CGFloat fontHeight = lastLabel.font.pointSize;
        if(lastLabel.attributedText.length > 0){
            fontHeight = [self getFontSizeOfAttributedText:lastLabel.attributedText];
        }
        return fontHeight * 0.5;
    }else{
        return 12;
    }
}

- (CGFloat)getFontSizeOfAttributedText:(NSAttributedString *)attributedText{
    CGFloat fontHeight = 11;
    if(attributedText.length > 0){
        UIFont *font = [[attributedText attributesAtIndex:0 effectiveRange:nil] objectForKey:NSFontAttributeName];
        fontHeight = font.pointSize+1;
    }
    return fontHeight;
}

- (CGRect)errorIconFrame{
    CGFloat width = 70;
    CGFloat height = 70;
    CGFloat topY = 10;
    return CGRectMake((CGRectGetWidth(self.bounds)-width)/2.0, topY, width, height);
}

- (CGRect)errTitleLabelFrame{
    
    CGFloat width = 200;
    CGFloat height = 20;
    CGFloat topY = CGRectGetMaxY([self errorIconFrame]) + 10;
    return CGRectMake((CGRectGetWidth(self.bounds)-width)/2.0, topY, width, height);

}

- (CGRect)errorDesLabelFrame{
    CGFloat width = 200;
    CGFloat height = 20;
    CGFloat topY = CGRectGetMaxY([self errTitleLabelFrame]) + 10;
    return CGRectMake((CGRectGetWidth(self.bounds)-width)/2.0, topY, width, height);
}

- (CGRect)errorRetryButtonFrame{
    CGFloat width = 80;
    CGFloat height = 40;
    CGFloat topY = CGRectGetMaxY([self errorDesLabelFrame]) + 10;
    return CGRectMake((CGRectGetWidth(self.bounds)-width)/2.0, topY, width, height);
}

@end

@interface EmptyErrorView()

@end

@implementation EmptyErrorView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.errImageIcon = @"illustration_emptystate";
        self.errTitle = NSLocalizedString(@"AddsVC_No data", @"no data~") ;
        self.errRetryButtonTitle = nil;
    }
    return self;
}

- (instancetype)initWithErrorIcon:(NSString *)errorIcon errorTitle:(NSString *)errorTitle subTitle:(NSString *)subTitle retryBtnTitle:(NSString *)retryBtnTitle frame:(CGRect)frame{
    self = [[EmptyErrorView alloc] initWithFrame:frame];
    if(self){
        self.errImageIcon = errorIcon;
        self.errTitle = errorTitle;
        self.errSubTitle = subTitle;
        self.errRetryButtonTitle = retryBtnTitle;
    }
    return self;
}

@end


@interface OfflineErrorView()

@end

@implementation OfflineErrorView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.errImageIcon = @"illustration_emptystate";
        self.errorTitleLabel.text = NSLocalizedString(@"Please check your network", @"error network~") ;
        [self.errorRetryButton setTitle:KKWTool_STR(@"Go to connect", nil) forState:UIControlStateNormal];
    }
    return self;
}

@end

@interface RequestErrorView()

@end

@implementation RequestErrorView

@end
