//
//  MyCell.h
//  TableView
//
//  Created by Alximik on 09.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell {
    UILabel *name;
    UIImageView *photo;
    UILabel *Shop;
    UILabel *Price;
}

@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UIImageView *photo;
@property (strong, nonatomic) IBOutlet UILabel *Shop;
@property (strong, nonatomic) IBOutlet UILabel *Price;

@end
