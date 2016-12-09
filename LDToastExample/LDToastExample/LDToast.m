//
//  LDToast.m
//  LDToastExample
//
//  Created by lioneldy on 2016/12/7.
//  Copyright © 2016年 lioneldy. All rights reserved.
//

#import "LDToast.h"

//Toast默认停留时间
#define ToastDispalyDuration 1.2f
//Toast到顶端/底端默认距离
#define ToastSpace 100.0f
//Toast背景颜色
#define ToastBackgroundColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75]
//Toast默认字体颜色
#define ToastTextColor [UIColor whiteColor]
//Toast默认高亮颜色
#define ToastHighlightColor [UIColor colorWithRed:1.f green:215/255.f blue:0.f alpha:1.f]
//Toast默认字体大小
#define ToastFontSize 16.f
//Toast默认高亮范围
#define ToastRange NSMakeRange(0, 0)

@interface LDToast ()
{
    UIButton *_contentView;
    CGFloat  _duration;
}
@end

@implementation LDToast

- (id)initWithText:(NSString *)text{
    if (self = [super init]) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
        CGRect rect=[text boundingRectWithSize:CGSizeMake(250,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,rect.size.width + 40, rect.size.height+ 20)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
//        _contentView.layer.cornerRadius = 8.0f;
        _contentView.backgroundColor = ToastBackgroundColor;
        [_contentView addSubview:textLabel];
        [_contentView addTarget:self action:@selector(toastTaped:) forControlEvents:UIControlEventTouchDown];
        _contentView.alpha = 0.0f;
        _duration = ToastDispalyDuration;
    }
    
    return self;
}

- (id)initWithText:(NSString *)text highlightRange:(NSRange)range fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor highlightFontSize:(CGFloat)highlightFontSize highlightColor:(UIColor *)highlightColor{
    if (self = [super init]) {
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:text];
        [attributedStr addAttribute:NSFontAttributeName
                              value:[UIFont boldSystemFontOfSize:((fontSize == 0) ? ToastFontSize : fontSize)]
                              range:NSMakeRange(0, [text length])];
        [attributedStr addAttribute:NSFontAttributeName
                              value:[UIFont boldSystemFontOfSize:((highlightFontSize == 0) ? ToastFontSize : highlightFontSize)]
                              range:range];
        [attributedStr addAttribute:NSForegroundColorAttributeName
                              value:((highlightColor == nil) ? ToastHighlightColor : highlightColor)
                              range:range];
        UIFont *font = [UIFont boldSystemFontOfSize:ToastFontSize];
        NSDictionary * dict=[NSDictionary dictionaryWithObject:font
                                                        forKey:NSFontAttributeName];
        CGRect rect=[text boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX)
                                       options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                    attributes:dict context:nil];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,rect.size.width + 40, rect.size.height+ 20)];
        
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = ((textColor == nil) ? ToastTextColor : textColor);
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.attributedText = attributedStr;
        textLabel.numberOfLines = 0;
        
        _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width, textLabel.frame.size.height)];
        _contentView.backgroundColor = ToastBackgroundColor;
//        _contentView.layer.cornerRadius = 8.0f;//toast背景框圆角
        [_contentView addSubview:textLabel];
        [_contentView addTarget:self action:@selector(toastTaped:) forControlEvents:UIControlEventTouchDown];
        _contentView.alpha = 0.0f;
        _duration = ToastDispalyDuration;
    }
    return self;
}


- (void)deviceOrientationDidChanged:(NSNotification *)notify{
    [self hideAnimation];
}

- (void)dismissToast{
    [_contentView removeFromSuperview];
}

- (void)toastTaped:(UIButton *)sender{
    [self hideAnimation];
}

- (void)setDuration:(CGFloat)duration{
    _duration = duration;
}

- (void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    _contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

-(void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    _contentView.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)show{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.center = window.center;
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

- (void)showFromTopOffset:(CGFloat)top{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.center = CGPointMake(window.center.x, top + _contentView.frame.size.height/2);
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

- (void)showFromBottomOffset:(CGFloat)bottom{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.center = CGPointMake(window.center.x, window.frame.size.height-(bottom + _contentView.frame.size.height/2));
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

- (void)showAtBottomWithSize:(CGSize)size {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - size.height, size.width, size.height);
    [window addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

#pragma mark-左下角显示部分高亮文字
+ (void)showCustomToastWithText:(NSString *)text
                       duration:(CGFloat)duration
                 highlightRange:(NSRange)range {
    [LDToast showCustomToastWithText:text
                            duration:duration
                      highlightRange:range
                            fontSize:ToastFontSize
                           textColor:ToastTextColor
                   highlightFontSize:ToastFontSize
                      highlightColor:ToastHighlightColor];
}

+ (void)showCustomToastWithText:(NSString *)text
                       duration:(CGFloat)duration
                 highlightRange:(NSRange)range
                       fontSize:(CGFloat)fontSize
                      textColor:(UIColor *)textColor
              highlightFontSize:(CGFloat)highlightFontSize
                 highlightColor:(UIColor *)highlightColor {
    UIFont *font = [UIFont boldSystemFontOfSize:ToastFontSize];
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font
                                                    forKey:NSFontAttributeName];
    CGRect rect=[text boundingRectWithSize:CGSizeMake(250,CGFLOAT_MAX)
                                   options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                attributes:dict context:nil];
    CGSize size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, rect.size.height + 20);
    LDToast *toast = [[LDToast alloc]initWithText:text
                                   highlightRange:range
                                         fontSize:fontSize
                                        textColor:textColor
                                highlightFontSize:highlightFontSize
                                   highlightColor:highlightColor];
    [toast setDuration:duration];
    [toast showAtBottomWithSize:size];
}

#pragma mark-中间显示
+ (void)showCenterWithText:(NSString *)text {
    [LDToast showCenterWithText:text duration:ToastDispalyDuration];
}

+ (void)showCenterWithText:(NSString *)text
                  duration:(CGFloat)duration {
    LDToast *toast = [[LDToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast show];
}

#pragma mark-上方显示
+ (void)showTopWithText:(NSString *)text {
    [LDToast showTopWithText:text  topOffset:ToastSpace duration:ToastDispalyDuration];
}

+ (void)showTopWithText:(NSString *)text
               duration:(CGFloat)duration {
    [LDToast showTopWithText:text  topOffset:ToastSpace duration:duration];
}

+ (void)showTopWithText:(NSString *)text
              topOffset:(CGFloat)topOffset {
    [LDToast showTopWithText:text  topOffset:topOffset duration:ToastDispalyDuration];
}

+ (void)showTopWithText:(NSString *)text
              topOffset:(CGFloat)topOffset
               duration:(CGFloat)duration {
    LDToast *toast = [[LDToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast showFromTopOffset:topOffset];
}

#pragma mark-下方显示高亮文字
+ (void)showBottomWithText:(NSString *)text {
    [LDToast showBottomWithText:text
                         offset:ToastSpace
                       duration:ToastDispalyDuration
                 highlightRange:ToastRange
                       fontSize:ToastFontSize
                      textColor:ToastTextColor
              highlightFontSize:ToastFontSize
                 highlightColor:ToastHighlightColor];
}

+ (void)showBottomWithText:(NSString *)text
                    offset:(CGFloat)offset
                  duration:(CGFloat)duration {
    [LDToast showBottomWithText:text
                         offset:offset
                       duration:duration
                 highlightRange:ToastRange
                       fontSize:ToastFontSize
                      textColor:ToastTextColor
              highlightFontSize:ToastFontSize
                 highlightColor:ToastHighlightColor];
}

+ (void)showBottomWithText:(NSString *)text
                    offset:(CGFloat)offset
                  duration:(CGFloat)duration
            highlightRange:(NSRange)range {
    [LDToast showBottomWithText:text
                         offset:offset
                       duration:duration
                 highlightRange:range
                       fontSize:ToastFontSize
                      textColor:ToastTextColor
              highlightFontSize:ToastFontSize
                 highlightColor:ToastHighlightColor];
}

+ (void)showBottomWithText:(NSString *)text
                    offset:(CGFloat)offset
                  duration:(CGFloat)duration
            highlightRange:(NSRange)range
                  fontSize:(CGFloat)fontSize
                 textColor:(UIColor *)textColor {
    [LDToast showBottomWithText:text
                         offset:offset
                       duration:duration
                 highlightRange:range
                       fontSize:fontSize
                      textColor:textColor
              highlightFontSize:ToastFontSize
                 highlightColor:ToastHighlightColor];
}

+ (void)showBottomWithText:(NSString *)text
                    offset:(CGFloat)offset
                  duration:(CGFloat)duration
            highlightRange:(NSRange)range
                  fontSize:(CGFloat)fontSize
                 textColor:(UIColor *)textColor
         highlightFontSize:(CGFloat)highlightFontSize
            highlightColor:(UIColor *)highlightColor {
    LDToast *toast = [[LDToast alloc]initWithText:text
                                   highlightRange:range
                                         fontSize:fontSize
                                        textColor:textColor
                                highlightFontSize:highlightFontSize
                                   highlightColor:highlightColor];
    [toast setDuration:duration];
    [toast showFromBottomOffset:offset];
}

@end
