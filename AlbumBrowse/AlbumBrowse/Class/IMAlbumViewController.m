//
//  IMAlbumViewController.m
//  AlbumBrowse
//
//  Created by Chentao on 15/4/30.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "IMAlbumViewController.h"
#import "IMAlbumModel.h"
#import "IMAlbumListViewController.h"
#import "IMAssetsGroup.h"
@interface IMAlbumViewController () <IMAlbumModelDelegate>

@property (nonatomic, strong) IMAlbumModel *albumModel;
@property (nonatomic, strong) IMAlbumListViewController *albumListViewController;
@property (nonatomic, strong) NSMutableArray *assetsGroups;

@end

@implementation IMAlbumViewController


+ (IMAlbumViewController *)albumViewController {
	IMAlbumListViewController *albumListViewController = [[IMAlbumListViewController alloc]init];
	IMAlbumViewController *albumViewController = [[IMAlbumViewController alloc]initWithAlbumListViewController:albumListViewController];
	return albumViewController;
}

- (instancetype)initWithAlbumListViewController:(IMAlbumListViewController *)albumListViewController {
	self = [super initWithRootViewController:albumListViewController];
	if (self) {
		_albumListViewController = albumListViewController;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	[self.albumModel loadAssetsGroupWithGroupTypes:@[
	     @(ALAssetsGroupSavedPhotos),
	     @(ALAssetsGroupPhotoStream),
	     @(ALAssetsGroupAlbum)
	 ]];
}

- (IMAlbumModel *)albumModel {
	if (!_albumModel) {
		_albumModel = [[IMAlbumModel alloc]init];
		_albumModel.delegate = self;
	}
	return _albumModel;
}

 #pragma mark - IMAlbumModelDelegate
- (void)albumModelLoadAssetsGroupSuccess:(IMAlbumModel *)albumModel andAssetsGroups:(NSArray *)assetsGroups {
	self.assetsGroups = [[NSMutableArray alloc]initWithCapacity:assetsGroups.count];
	for (ALAssetsGroup *group  in assetsGroups) {
		IMAssetsGroup *agroup = [[IMAssetsGroup alloc]init];
		agroup.name = [group valueForProperty:ALAssetsGroupPropertyName];
		agroup.count = group.numberOfAssets;
		agroup.cover = [UIImage imageWithCGImage:[group posterImage]];
		[self.assetsGroups addObject:agroup];
	}

	if (self.albumListViewController) {
		self.albumListViewController.dataSource = self.assetsGroups;
	}
}

- (void)albumModelLoadAssetsGroupFailure:(IMAlbumModel *)albumModel andError:(NSError *)error {
}

 #pragma mark -


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
