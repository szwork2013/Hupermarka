//
//  ShopsViewController.h
//  Hypermarka
//
//  Created by Bogdan Redkin on 09.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"   
#import "MyCell.h"

@interface ShopsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *NavTitle;
- (IBAction)BackButton:(id)sender;

@property (retain, nonatomic) NSMutableArray *Titles;
@property (strong, nonatomic) NSMutableArray *Prices;
@property (strong, nonatomic) NSMutableArray *Images;
@property (strong, nonatomic) NSMutableArray *Shops;
@property (strong, nonatomic) NSMutableArray *ImagesNames;
@property (weak, nonatomic) IBOutlet UITableView *CatTableView;


@end
