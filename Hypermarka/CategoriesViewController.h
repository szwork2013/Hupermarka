//
//  CategoriesViewController.h
//  Hypermarka
//
//  Created by Bogdan Redkin on 04.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
#import "Cell1.h"
#import "Cell2.h"

@interface CategoriesViewController : UIViewController{
}
@property (strong,nonatomic) NSMutableArray *arSelectedIndexPaths;
@property (strong,nonatomic) UITableViewCell *CellIndexPathes;
@property (strong,nonatomic) NSMutableArray *lists;

@end
