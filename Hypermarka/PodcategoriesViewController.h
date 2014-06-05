//
//  PodcategoriesViewController.h
//  Hypermarka
//
//  Created by Bogdan Redkin on 04.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface PodcategoriesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationBar *NavigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *TitleNavigation;
@property (strong,nonatomic) NSMutableArray *arSelectedIndexPaths;
@property (strong,nonatomic) UITableViewCell *CellIndexPathes;
@property (strong,nonatomic) NSMutableArray *lists;
@property (strong,nonatomic) NSMutableArray *tableData;
- (IBAction)BackButton:(id)sender;

@end
