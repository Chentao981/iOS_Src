//
//  ViewController.m
//  CTUILayout
//
//  Created by Chentao on 15/2/3.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
  MainView *mainView = [[MainView alloc] init];
  mainView.backgroundColor = [UIColor whiteColor];
  self.view = mainView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
