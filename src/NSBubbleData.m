//
//  NSBubbleData.m
//
//  Created by Alex Barinov
//  Project home page: http://alexbarinov.github.com/UIBubbleTableView/
//
//  This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License.
//  To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/
//

#import "NSBubbleData.h"

#import "NSString+REWNSString.h"
#import "REWAppDelegate.h"

#import <QuartzCore/QuartzCore.h>

@implementation NSBubbleData

#pragma mark - Properties

@synthesize date = _date;
@synthesize type = _type;
@synthesize view = _view;
@synthesize insets = _insets;
@synthesize avatar = _avatar;



#pragma mark - Text bubble

const UIEdgeInsets textInsetsMine = {5, 10, 11, 17};
const UIEdgeInsets textInsetsSomeone = {5, 15, 11, 10};

+ (id)dataWithText:(NSString *)text date:(NSDate *)date type:(NSBubbleType)type {

    return [[NSBubbleData alloc] initWithText:text date:date type:type];
}


+ (id)dataWithText:(NSString *)text date:(NSDate *)date type:(NSBubbleType)type font:(UIFont *)font {

    return [[NSBubbleData alloc] initWithText:text date:date type:type font:font];
}



- (id)initWithText:(NSString *)text date:(NSDate *)date type:(NSBubbleType)type
{
    return [self initWithText:text date:date type:type font:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
}

- (id)initWithText:(NSString *)text date:(NSDate *)date type:(NSBubbleType)type font:(UIFont *)font {
    
    CGSize size = [(text ? text : @"") sizeWithFont:font constrainedToSize:CGSizeMake(220, 9999) lineBreakMode:NSLineBreakByWordWrapping];
    
    REWVisualStyle *style = [REWAppDelegate instance].visualStyle;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.text = (text ? text : @"");
    label.font = font;
    label.backgroundColor = [UIColor clearColor];

    
    UIEdgeInsets insets = (type == BubbleTypeMine ? textInsetsMine : textInsetsSomeone);
    return [self initWithView:label date:date type:type insets:insets];
}

#pragma mark - Image bubble

const UIEdgeInsets imageInsetsMine = {11, 13, 16, 22};
const UIEdgeInsets imageInsetsSomeone = {11, 18, 16, 14};

+ (id)dataWithImage:(UIImage *)image date:(NSDate *)date type:(NSBubbleType)type
{

    return [[NSBubbleData alloc] initWithImage:image date:date type:type];

}

- (id)initWithImage:(UIImage *)image date:(NSDate *)date type:(NSBubbleType)type
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    CGSize size = image.size;
    
    size.width /= scale;
    size.height /= scale;
    
    if (size.width > 220)
    {
        size.height /= (size.width / 220);
        size.width = 220;
        
    } else if (size.height > 260) {
        
        size.width /= (size.height / 260);
        size.height = 260;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    imageView.image = image;
    imageView.layer.cornerRadius = 5.0;
    imageView.layer.masksToBounds = YES;

    
    UIEdgeInsets insets = (type == BubbleTypeMine ? imageInsetsMine : imageInsetsSomeone);
    return [self initWithView:imageView date:date type:type insets:insets];       
}



- (id)initWithRemoteImage:(NSString *)imageURL date:(NSDate *)date type:(NSBubbleType)type {
    
    REWConversationBubbleImageView *imageView = [[REWConversationBubbleImageView alloc] initWithImageURL:imageURL];
    
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 5.0;
    
    imageView.delegate = self;
    
    UIEdgeInsets insets = (type == BubbleTypeMine ? imageInsetsMine : imageInsetsSomeone);
    return [self initWithView:imageView date:date type:type insets:insets];
}


+ (id)dataWithRemoteImage:(NSString *)imageURL date:(NSDate *)date type:(NSBubbleType)type {
    
    NSString *imageKey = [NSString stringWithFormat:@"%@%f%f%f", imageURL, 140.0, 100.0, [UIScreen mainScreen].scale];
    
    UIImage *cached = [[SDImageCache sharedImageCache] imageFromKey:imageKey fromDisk:YES];
    
    if (cached) {
        return [NSBubbleData dataWithImage:cached date:date type:type];
    }
    
    return [[NSBubbleData alloc] initWithRemoteImage:imageURL date:date type:type];
}



#pragma mark - Custom view bubble

+ (id)dataWithView:(UIView *)view date:(NSDate *)date type:(NSBubbleType)type insets:(UIEdgeInsets)insets {
    
    return [[NSBubbleData alloc] initWithView:view date:date type:type insets:insets];
}

- (id)initWithView:(UIView *)view date:(NSDate *)date type:(NSBubbleType)type insets:(UIEdgeInsets)insets  
{
    self = [super init];
    if (self)
    {

        _view = view;
        _date = date;

        _type = type;
        _insets = insets;
    }
    return self;
}


- (void)rewConversationBubbleImage:(REWConversationBubbleImageView *)view didDownloadImage:(UIImage *)image {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(bubbleDataViewDidChange:view:)]) {
            [self.delegate bubbleDataViewDidChange:self view:view];
        }
    }
}


@end
