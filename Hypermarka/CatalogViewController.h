//
//  CatalogViewController.h
//  Hypermarka
//
//  Created by Bogdan Redkin on 04.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface CatalogViewController : UIViewController

@property (retain, nonatomic) NSMutableArray *Titles;
@property (strong, nonatomic) NSMutableArray *Prices;
@property (strong, nonatomic) NSMutableArray *Images;
@property (strong, nonatomic) NSMutableArray *Shops;
@property (weak, nonatomic) IBOutlet UINavigationItem *NivigationTitle;
@property (weak, nonatomic) IBOutlet UITableView *CatTableView;

@end