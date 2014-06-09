//
//  TableViewController.h
//  Hypermarka
//
//  Created by Bogdan Redkin on 13.05.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface TableViewController : UIViewController{
}

@property (strong,nonatomic) NSMutableArray *arSelectedIndexPaths;
@property (strong,nonatomic) UITableViewCell *CellIndexPathes;
@property (strong,nonatomic) NSMutableArray *lists;
@property (strong,nonatomic) NSMutableArray *tableData;
- (IBAction)BackButton:(id)sender;

@end
