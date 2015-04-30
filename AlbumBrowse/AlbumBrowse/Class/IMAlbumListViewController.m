//
//  IMAlbumListViewController.m
//  AlbumBrowse
//
//  Created by Chentao on 15/4/29.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "IMAlbumListViewController.h"
#import "IMAlbumListViewCell.h"
@interface IMAlbumListViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation IMAlbumListViewController


- (void)loadView {
	UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableView.dataSource = self;
	tableView.delegate = self;
	self.view = tableView;
}

- (UITableView *)tableView {
	return (UITableView *)self.view;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	NSIndexPath *selectedIndexPath = [[self tableView] indexPathForSelectedRow];
	if (selectedIndexPath) {
		[[self tableView] deselectRowAtIndexPath:selectedIndexPath animated:YES];
	}
}

- (void)setDataSource:(NSArray *)dataSource {
	_dataSource = dataSource;
	[[self tableView] reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"IMAlbumListViewCell";
	IMAlbumListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[IMAlbumListViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
	cell.cellData = [self.dataSource objectAtIndex:indexPath.row];

	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return IMAlbumListViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UIViewController *cc = [[UIViewController alloc]init];
	[self.navigationController pushViewController:cc animated:YES];
}

#pragma mark -
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
