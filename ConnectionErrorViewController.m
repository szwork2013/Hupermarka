//
//  ConnectionErrorViewController.m
//  Hypermarka
//
//  Created by Bogdan Redkin on 23.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "ConnectionErrorViewController.h"

@interface ConnectionErrorViewController ()

@end

@implementation ConnectionErrorViewController
@synthesize TextError;

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
    [super viewDidLoad];
    TextError.text = @"";
}


@end
