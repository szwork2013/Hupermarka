//
//  ArendaViewController.m
//  Hypermarka
//
//  Created by Bogdan Redkin on 11.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "ArendaViewController.h"

@interface ArendaViewController ()

@end

@implementation ArendaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)MenuButton:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    [self.frostedViewController presentMenuViewController];

}
@end
