//
//  IMAlbumViewController.h
//  AlbumBrowse
//
//  Created by Chentao on 15/4/30.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMAlbumListViewController.h"

@interface IMAlbumViewController : UINavigationController

- (instancetype)initWithAlbumListViewController:(IMAlbumListViewController *)albumListViewController;

+ (IMAlbumViewController *)albumViewController;

@end
