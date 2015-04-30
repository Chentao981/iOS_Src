//
//  IMAlbumModel.m
//  AlbumBrowse
//
//  Created by Chentao on 15/4/30.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "IMAlbumModel.h"

@interface IMAlbumModel ()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@end

@implementation IMAlbumModel



- (instancetype)init {
	self = [super init];
	if (self) {
		ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
		self.assetsLibrary = assetsLibrary;
	}
	return self;
}

- (void)loadAssetsGroupWithGroupTypes:(NSArray *)groupTypes {
	__block NSMutableArray *assetsGroups = [NSMutableArray array];
	__block NSUInteger numberOfFinishedTypes = 0;

	for (NSNumber *type in groupTypes) {
		__weak typeof(self) weakSelf = self;

		[self.assetsLibrary enumerateGroupsWithTypes:[type unsignedIntegerValue] usingBlock: ^(ALAssetsGroup *group, BOOL *stop) {
		    if (group) {
		        [group setAssetsFilter:[weakSelf assetsFilterWithFilterType:weakSelf.filterType]];
		        if (group.numberOfAssets > 0) {
		            [assetsGroups addObject:group];
				}
			}
		    else {
		        numberOfFinishedTypes++;
			}
		    if (numberOfFinishedTypes == groupTypes.count) {
		        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(albumModelLoadAssetsGroupSuccess:andAssetsGroups:)]) {
		            [weakSelf.delegate albumModelLoadAssetsGroupSuccess:weakSelf andAssetsGroups:assetsGroups];
				}
			}
		} failureBlock: ^(NSError *error) {
		    if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(albumModelLoadAssetsGroupFailure:andError:)]) {
		        [weakSelf.delegate albumModelLoadAssetsGroupFailure:weakSelf andError:error];
			}
		}];
	}
}

- (ALAssetsFilter *)assetsFilterWithFilterType:(AssetFilterType)type {
	switch (type) {
		case AssetFilterTypeAll:
			return [ALAssetsFilter allAssets];
			break;

		case AssetFilterTypePhotos:
			return [ALAssetsFilter allPhotos];
			break;

		case AssetFilterTypeVideos:
			return [ALAssetsFilter allVideos];
			break;
	}
}

@end
