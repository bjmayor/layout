//
//  DemoViewController.m
//  LayoutDemo
//
//  Created by shunpingliu on 14-2-28.
//  Copyright (c) 2014年 MojiChina. All rights reserved.
//

#import "DemoViewController.h"
#import "UIView+LinearLayout.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    for (int i=0; i< 5; i++) {
         UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        testView.marginLeft = 100;
        testView.marginBottom = 10;
        [self.view addSubview:testView];
    }
    self.view.debugMode = YES;
    [self.view linearLayout:LayoutVertical];
//    [self.view linearLayout:LayoutHorizontal];
    
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
