//
//  NSBubbleData.h
//
//  Created by Alex Barinov
//  Project home page: http://alexbarinov.github.com/UIBubbleTableView/
//
//  This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
//  To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
//

#import <Foundation/Foundation.h>
#import "REWConversationBubbleImageView.h"

typedef enum _NSBubbleType
{
    BubbleTypeMine = 0,
    BubbleTypeSomeoneElse = 1
} NSBubbleType;

@class NSBubbleData;

@protocol NSBubbleDataDelegate <NSObject>

@optional
- (void)bubbleDataViewDidChange:(NSBubbleData *)bubbleData view:(UIView *)view;

@end

@interface NSBubbleData : NSObject <REWConversationBubbleImageDelegate>

@property (readonly, nonatomic, strong) NSDate *date;
@property (readonly, nonatomic) NSBubbleType type;
@property (readonly, nonatomic, strong) UIView *view;
@property (readonly, nonatomic) UIEdgeInsets insets;
@property (nonatomic, strong) UIImage *avatar;

@property (nonatomic, weak) id <NSBubbleDataDelegate> delegate;

- (id)initWithText:(NSString *)text date:(NSDate *)date type:(NSBubbleType)type;

- (id)initWithText:(NSString *)text date:(NSDate *)date type:(NSBubbleType)type font:(UIFont *)font;


+ (id)dataWithText:(NSString *)text date:(NSDate *)date type:(NSBubbleType)type;

+ (id)dataWithText:(NSString *)text date:(NSDate *)date type:(NSBubbleType)type font:(UIFont *)font;


- (id)initWithImage:(UIImage *)image date:(NSDate *)date type:(NSBubbleType)type;
+ (id)dataWithImage:(UIImage *)image date:(NSDate *)date type:(NSBubbleType)type;

- (id)initWithView:(UIView *)view date:(NSDate *)date type:(NSBubbleType)type insets:(UIEdgeInsets)insets;
+ (id)dataWithView:(UIView *)view date:(NSDate *)date type:(NSBubbleType)type insets:(UIEdgeInsets)insets;

@end
