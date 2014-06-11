//
//  InfoViewController.m
//  Hypermarka
//
//  Created by Bogdan Redkin on 06.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize NavigationTitle;

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
    NavigationTitle.title = [Singleton sharedMySingleton].TitleForInfo;
    [Singleton sharedMySingleton].InfoClosed = NO;
    NSString *htmlString = [[Singleton sharedMySingleton].info2 objectAtIndex:0];
    [htmlString stringByDecodingXMLEntities];
    NSLog(@"Info: %@", htmlString);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)BackButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    [Singleton sharedMySingleton].InfoClosed = YES;

}

@end
