//
//  IMAlbumModel.h
//  AlbumBrowse
//
//  Created by Chentao on 15/4/30.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef NS_ENUM (NSUInteger, AssetFilterType) {
	AssetFilterTypeAll,
	AssetFilterTypePhotos,
	AssetFilterTypeVideos
};

@class IMAlbumModel;
@protocol IMAlbumModelDelegate <NSObject>

- (void)albumModelLoadAssetsGroupSuccess:(IMAlbumModel *)albumModel andAssetsGroups:(NSArray *)assetsGroups;
- (void)albumModelLoadAssetsGroupFailure:(IMAlbumModel *)albumModel andError:(NSError *)error;

@end

@interface IMAlbumModel : NSObject

/**
 * 资源过滤选项
 **/
@property (nonatomic, assign) AssetFilterType filterType;

@property (nonatomic, weak) id <IMAlbumModelDelegate> delegate;

/**
 * groupTypes的取值为:ALAssetsGroupSavedPhotos,ALAssetsGroupPhotoStream,ALAssetsGroupAlbum
 **/
- (void)loadAssetsGroupWithGroupTypes:(NSArray *)groupTypes;

@end
