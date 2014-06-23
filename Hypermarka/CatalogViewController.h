//
//  CatalogViewController.h
//  Hypermarka
//
//  Created by Bogdan Redkin on 04.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
#import "MyCell.h"
#import "Reachability.h"
#import "CatalogDownloads.h"
#import "ProgressHUD.h"

@interface CatalogViewController : UIViewController{
}

@property (retain, nonatomic) NSMutableArray *Titles;
@property (strong, nonatomic) NSMutableArray *Prices;
@property (strong, nonatomic) NSMutableArray *Images;
@property (strong, nonatomic) NSMutableArray *Shops;
@property (strong, nonatomic) NSMutableArray *info;
@property (strong, nonatomic) NSMutableArray *ImagesNames;
@property (weak, nonatomic) IBOutlet UINavigationItem *NivigationTitle;
@property (weak, nonatomic) IBOutlet UITableView *CatTableView;
@property (nonatomic) BOOL downloadImage;
@property (nonatomic) int number;


@end
