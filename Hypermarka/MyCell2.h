//
//  MyCell2.h
//  Hypermarka
//
//  Created by Bogdan Redkin on 09.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell2 : UITableViewCell {
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
