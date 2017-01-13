
//
//  PRAirDropData.m
//  PRAirDropDemo
//
//  Created by pengrun on 2017/1/12.
//  Copyright © 2017年 pengrun. All rights reserved.
//

#import "PRAirDropData.h"

@implementation PRAirDropData
- (id)initWithURL:(NSURL *)url subject:(NSString *)subject;
{
    self = [super init];
    if (self != nil) {
        self.url = url;
        self.subject = subject;
    }
    return self;
}

- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return self.url;
}

- (id)activityViewController:(UIActivityViewController *)activityViewController
         itemForActivityType:(NSString *)activityType
{
    return self.url;
}

- (NSString *)activityViewController:(UIActivityViewController *)activityViewController
              subjectForActivityType:(NSString *)activityType
{
    return self.subject;
}

- (UIImage *)activityViewController:(UIActivityViewController *)activityViewController
      thumbnailImageForActivityType:(NSString *)activityType
                      suggestedSize:(CGSize)size
{
    if ([activityType isEqualToString:UIActivityTypeAirDrop]) {
        return [UIImage imageNamed:@"logo"];
    }
    return nil;
}
@end
