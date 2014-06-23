//
//  Error.m
//  Hypermarka
//
//  Created by Tori on 19.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "Error.h"
#import "REFrostedViewController.h"
@interface Error ()

@end

@implementation Error

- (IBAction)MenuButton:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    [self.frostedViewController presentMenuViewController];

}

@end
