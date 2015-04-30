//
//  IMAssetsGroup.h
//  AlbumBrowse
//
//  Created by Chentao on 15/4/30.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface IMAssetsGroup : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) UIImage *cover;

@end
