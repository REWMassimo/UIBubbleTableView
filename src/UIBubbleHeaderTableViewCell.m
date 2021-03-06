//
//  UIBubbleHeaderTableViewCell.m
//  UIBubbleTableViewExample
//
//  Created by Александр Баринов on 10/7/12.
//  Copyright (c) 2012 Stex Group. All rights reserved.
//

#import "UIBubbleHeaderTableViewCell.h"
#import "REWAppDelegate.h"


@interface UIBubbleHeaderTableViewCell ()

@property (nonatomic) UILabel *label;

@end

@implementation UIBubbleHeaderTableViewCell

@synthesize label = _label;
@synthesize date = _date;

+ (CGFloat)height
{
    return 28.0;
}

- (void)setDate:(NSDate *)value
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *text = [dateFormatter stringFromDate:value];
#if !__has_feature(objc_arc)
    [dateFormatter release];
#endif
    
    if (self.label)
    {
        self.label.text = text;
        return;
    }
    
    REWVisualStyle *style = [REWAppDelegate instance].visualStyle;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = style.messagesBackgroundColor;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [UIBubbleHeaderTableViewCell height])];
    self.label.text = text;
    self.label.font = [UIFont [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    self.label.textAlignment = NSTextAlignmentCenter;
                       
    self.label.textColor = style.messagesTimestampColor;
    self.label.backgroundColor = self.backgroundColor;

    [self addSubview:self.label];
}



@end
