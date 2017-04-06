//
//  REWConversationBubbleImageView.h
//
//
//  Created by Massimo Savino on 2017-Apr-06.
//  Copyright (c) 2017 Real Estate Webmasters. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REWImageLoader.h"


@class REWConversationBubbleImageView;


@protocol REWConversationBubbleImageDelegate <NSObject>

@optional
- (void) rewConversationBubbleImage:(REWConversationBubbleImageView *)view didDownloadImage:(UIImage *)image;

@end


@interface REWConversationBubbleImageView : UIView <REWImageLoaderDelegate>

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak) id <REWConversationBubbleImageDelegate> delegate;


- (instancetype)initWithImageURL:(NSString *)imageURL;

@end
