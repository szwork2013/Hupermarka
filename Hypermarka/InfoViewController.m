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
@synthesize NavigationTitle, webView;
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
    if ([Singleton sharedMySingleton].info2) {
        NSString *htmlString = [[Singleton sharedMySingleton].info2 objectAtIndex:0];
        NSString *image = [NSString stringWithFormat:@"<p style = 'margin-top: 10px;'> <img src = '%@' width = '100px' height = '100px;' style = 'float:left; margin: 7px 7px 7px 0'>", [Singleton sharedMySingleton].imageURL];
        NSString *price = [NSString stringWithFormat:@"</table><p> Цена = %@", [Singleton sharedMySingleton].price];
        NSMutableString *post = [NSMutableString stringWithString:htmlString];
        [post replaceOccurrencesOfString:@"&#60;" withString:@"<" options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        [post replaceOccurrencesOfString:@"&#62;" withString:@">" options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        [post replaceOccurrencesOfString:@"&#13;&#10;" withString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        [post replaceOccurrencesOfString:@"&#38;" withString:@"&" options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        [post replaceOccurrencesOfString:@"<table>" withString:@"<table border='1'" options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        [post replaceOccurrencesOfString:@"<p>" withString:image options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        [post replaceOccurrencesOfString:@"</table>" withString:price options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        
        [webView loadHTMLString:post baseURL:nil];
    }
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
