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
    NavigationTitle.title = [Singleton sharedMySingleton].TitleForInfoView;
    if ([Singleton sharedMySingleton].DataForInfoView) {
        NSString *htmlString = [[Singleton sharedMySingleton].DataForInfoView objectAtIndex:0];
        NSString *image = [NSString stringWithFormat:@"<p style = 'margin-top: 10px;'> <img src = '%@' width = '100px' height = '100px;' style = 'float:left; margin: 7px 7px 7px 0'>", [Singleton sharedMySingleton].imageURL];
        NSString *price = [NSString stringWithFormat:@"</table><p> Цена = %@", [Singleton sharedMySingleton].priceForElementsOfCatalog];
        NSMutableString *post = [NSMutableString stringWithString:htmlString];
        [post replaceOccurrencesOfString:@"&#60;" withString:@"<" options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        [post replaceOccurrencesOfString:@"&#62;" withString:@">" options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        [post replaceOccurrencesOfString:@"&#13;&#10;" withString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        [post replaceOccurrencesOfString:@"&#38;" withString:@"&" options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        [post replaceOccurrencesOfString:@"<table>" withString:@"<table border='1' border-style='solid'" options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        [post replaceOccurrencesOfString:@"<p>" withString:image options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        [post replaceOccurrencesOfString:@"</table>" withString:price options:NSCaseInsensitiveSearch range:NSMakeRange(0, post.length)];
        
        [webView loadHTMLString:post baseURL:nil];
    }
}



@end
