//
//  PRAirDropData.h
//  PRAirDropDemo
//
//  Created by pengrun on 2017/1/12.
//  Copyright © 2017年 pengrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PRAirDropData : NSObject <UIActivityItemSource>
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *subject;

- (id)initWithURL:(NSURL *)url subject:(NSString *)subject;
@end
