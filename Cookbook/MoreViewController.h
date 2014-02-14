//
//  MoreViewController.h
//  Cookbook
//
//  Created by Walker Christie on 2/10/14.
//  Copyright (c) 2014 Walker Christie. All rights reserved.
//

#import "ViewController.h"

@interface MoreViewController : ViewController <UITabBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UITabBar *customTabBar;
@property (nonatomic, weak) IBOutlet UICollectionView *collection;

@end
