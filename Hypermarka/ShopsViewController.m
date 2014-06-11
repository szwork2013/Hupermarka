//
//  ShopsViewController.m
//  Hypermarka
//
//  Created by Bogdan Redkin on 09.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "ShopsViewController.h"

@interface ShopsViewController ()

@end

@implementation ShopsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
}

-(IBAction)BackButton:(id)sender{
    [self dismissModalViewControllerAnimated:YES];    
}
@end
