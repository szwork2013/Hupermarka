//
//  StartDownloads.m
//  Hypermarka
//
//  Created by Bogdan Redkin on 18.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "StartDownloads.h"

@interface StartDownloads ()

@end

@implementation StartDownloads

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
}
-(NSData *)data{
    NSData *data = [[NSData alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://work.hypermarka.com/hm/proto/secview?obj=0"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:15];
    request.HTTPMethod=PostMethod;
    NSError* connectionError=nil;
    NSHTTPURLResponse* response=nil;
    data =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
    if (!response.statusCode) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Отсутствует соеденение с сетью интернет, пожалуйста, подключите интернет и повторите попытку"
                                                       delegate:self
                                              cancelButtonTitle:@"ОК"
                                              otherButtonTitles:nil];
        [alert show];
    }
    NSString *allDataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableString *mutableData = [NSMutableString stringWithString:allDataString];
    [mutableData replaceCharactersInRange:NSMakeRange(0, 1) withString:@"{"];
    int a = [mutableData length]-2;
    [mutableData replaceCharactersInRange:NSMakeRange(a, 1) withString:@"}"];
    NSString *DataStr = [NSString stringWithString:mutableData];
    NSData *allData = [DataStr dataUsingEncoding:NSUTF8StringEncoding];
    return allData;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        UIStoryboard *storyboard = self.storyboard;
        StartDownloads *finished = [storyboard instantiateViewControllerWithIdentifier:@"ConnectionError"];
        
        [self presentViewController:finished animated:YES completion:NULL];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
@end
