//
//  REWConversationBubbleImageView.m
//
//
//  Created by Massimo Savino on 2017-Apr-06.
//  Copyright (c) 2017 Real Estate Webmasters. All rights reserved.
//
//

#import "REWConversationBubbleImageView.h"


@interface REWConversationBubbleImageView ()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end


@implementation REWConversationBubbleImageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // init here if customised further
    }
    
    return self;
    
}


- (instancetype)initWithImageURL:(NSString *)imageURL {
    
    self = [self initWithFrame:CGRectMake(0, 0, 26, 26)];
    
    if (self) {
        
        self.imageURL = imageURL;
        
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        
        CGRect r = self.activityView.frame;
        
        r.origin.x = (self.frame.size.width / 2.0) - (r.size.width / 2.0);
        r.origin.y = (self.frame.size.height / 2.0) - (r.size.height / 2.0);
        
        self.activityView.frame = r;
        
        [self.activityView startAnimating];
        [self addSubview:self.activityView];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.imageView.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:self.imageView];
    }
    return self;
}


- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    if (!self.imageView || !self.imageView.image) {
        
        REWImageLoader *loader = [[REWImageLoader alloc] initWithURL:self.imageURL imageIndex:0 resizeWidth:140 resizeHeight:100];
        
        loader.delegate = self;
        [loader startLoading:NO];
        
    } else if (self.imageView && self.imageView.image) {
        
        CGRect r = self.frame;
        
        r.size.width = self.imageView.image.size.width;
        r.size.height = self.imageView.image.size.height;
        
        self.frame = r;
    }
}


- (void)rewImageLoader:(REWImageLoader *)loader didDownloadImageWithSuccess:(BOOL)success index:(NSInteger)index section:(NSInteger)section image:(UIImage *)image retrievedFromCache:(BOOL)retrievedFromCache {
    
    if (success) {
        
        self.imageView.image = image;
        self.imageView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        }];
        
        [self.activityView removeFromSuperview];
        
        [self layoutSubviews];
        
        if (self.delegate) {
            
            if ([self.delegate respondsToSelector:@selector(rewConversationBubbleImage:didDownloadImage:)]) {
                [self.delegate rewConversationBubbleImage:self didDownloadImage:self.imageView.image];
            }
        }
    }
    
}


@end
