//
//  MainViewController.m
//  AlbumBrowse
//
//  Created by Chentao on 15/4/30.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "MainViewController.h"
#import "IMAlbumViewController.h"

//#import "IMAlbumModel.h"

@interface MainViewController ()
//<IMAlbumModelDelegate>
//@property (nonatomic, strong) IMAlbumModel *albumModel;
@end

@implementation MainViewController

- (void)viewDidLoad {
	[super viewDidLoad];


	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	[button addTarget:self action:@selector(buttonTouchHandler) forControlEvents:UIControlEventTouchUpInside];
	button.backgroundColor = [UIColor grayColor];
	button.frame = CGRectMake(50, 100, 100, 40);
	[button setTitle:@"相 册" forState:UIControlStateNormal];
	[self.view addSubview:button];

	// Do any additional setup after loading the view.
}

- (void)buttonTouchHandler {
	IMAlbumViewController *albumViewController = [IMAlbumViewController albumViewController];
	[self.navigationController presentViewController:albumViewController animated:YES completion:nil];

//	_albumModel = [[IMAlbumModel alloc]init];
//	_albumModel.delegate = self;
//	[_albumModel loadAssetsGroupWithGroupTypes:@[
//	     @(ALAssetsGroupSavedPhotos),
//	     @(ALAssetsGroupPhotoStream),
//	     @(ALAssetsGroupAlbum)
//	 ]];
}

//- (void)albumModelLoadAssetsGroupSuccess:(IMAlbumModel *)albumModel andAssetsGroups:(NSArray *)assetsGroups {
//}
//
//- (void)albumModelLoadAssetsGroupFailure:(IMAlbumModel *)albumModel andError:(NSError *)error {
//}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
   #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */

@end
