//
//  LDToast.h
//  LDToastExample
//
//  Created by lioneldy on 2016/12/7.
//  Copyright © 2016年 lioneldy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LDToast : NSObject

#pragma mark-中间显示
/**
 *  中间显示
 *
 *  @param text 内容
 */
+ (void)showCenterWithText:(NSString *)text;
/**
 *  中间显示+自定义停留时间
 *
 *  @param text     内容
 *  @param duration 停留时间
 */
+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration;

#pragma mark-上方显示
/**
 *  上方显示
 *
 *  @param text 内容
 */
+ (void)showTopWithText:(NSString *)text;
/**
 *  上方显示+自定义停留时间
 *
 *  @param text     内容
 *  @param duration 停留时间
 */
+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration;
/**
 *  上方显示+自定义距顶端距离
 *
 *  @param text      内容
 *  @param topOffset 到顶端距离
 */
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset;
/**
 *  上方显示+自定义距顶端距离+自定义停留时间
 *
 *  @param text      内容
 *  @param topOffset 到顶端距离
 *  @param duration  停留时间
 */
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration;

#pragma mark-左下角显示高亮文字
/**
 *  左下角显示+自定义高亮文字+自定义停留时间
 *
 *  @param text         内容
 *  @param duration     停留时间
 *  @param range        高亮范围
 */
+ (void)showCustomToastWithText:(NSString *)text duration:(CGFloat)duration highlightRange:(NSRange)range;
/**
 *  左下方显示+自定义距底端距离+自定义高亮文字+自定义停留时间+字体大小+字体颜色+高亮字体大小+高亮字体颜色
 *
 *  @param text                 内容
 *  @param duration             停留时间
 *  @param range                高亮范围
 *  @param fontSize             字体大小（传0则使用默认值）
 *  @param textColor            字体颜色（传nil则使用默认值）
 *  @param highlightFontSize    高亮字体大小（传0则使用默认值）
 *  @param highlightColor       高亮字体颜色（传nil则使用默认值）
 */
+ (void)showCustomToastWithText:(NSString *)text duration:(CGFloat)duration highlightRange:(NSRange)range fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor highlightFontSize:(CGFloat)highlightFontSize highlightColor:(UIColor *)highlightColor;

#pragma mark-下方显示高亮文字
/**
 *  下方显示
 *
 *  @param text 内容
 */
+ (void)showBottomWithText:(NSString *)text;
/**
 *  下方显示+自定义距底端距离+自定义停留时间
 *
 *  @param text     内容
 *  @param offset   距底端距离
 *  @param duration 停留时间
 */
+ (void)showBottomWithText:(NSString *)text offset:(CGFloat)offset duration:(CGFloat)duration;
/**
 *  下方显示+自定义距底端距离+自定义高亮文字+自定义停留时间
 *
 *  @param text         内容
 *  @param offset       距底端距离
 *  @param duration     停留时间
 *  @param range        高亮范围
 */
+ (void)showBottomWithText:(NSString *)text offset:(CGFloat)offset duration:(CGFloat)duration highlightRange:(NSRange)range;
/**
 *  下方显示+自定义距底端距离+自定义高亮文字+自定义停留时间+字体大小+字体颜色
 *
 *  @param text         内容
 *  @param offset       距底端距离
 *  @param duration     停留时间
 *  @param range        高亮范围
 *  @param fontSize     字体大小（传0则使用默认值）
 *  @param textColor    字体颜色（传nil则使用默认值）
 */
+ (void)showBottomWithText:(NSString *)text offset:(CGFloat)offset duration:(CGFloat)duration highlightRange:(NSRange)range fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor;
/**
 *  下方显示+自定义距底端距离+自定义高亮文字+自定义停留时间+字体大小+字体颜色+高亮字体大小+高亮字体颜色
 *
 *  @param text                 内容
 *  @param offset               距底端距离
 *  @param duration             停留时间
 *  @param range                高亮范围
 *  @param fontSize             字体大小（传0则使用默认值）
 *  @param textColor            字体颜色（传nil则使用默认值）
 *  @param highlightFontSize    高亮字体大小（传0则使用默认值）
 *  @param highlightColor       高亮字体颜色（传nil则使用默认值）
 */
+ (void)showBottomWithText:(NSString *)text offset:(CGFloat)offset duration:(CGFloat)duration highlightRange:(NSRange)range fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor highlightFontSize:(CGFloat)highlightFontSize highlightColor:(UIColor *)highlightColor;

@end
