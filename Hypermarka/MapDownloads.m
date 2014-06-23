//
//  MapDownloads.m
//  Hypermarka
//
//  Created by Bogdan Redkin on 18.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "MapDownloads.h"

@interface MapDownloads ()

@end

@implementation MapDownloads

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
-(NSData *)DataForMaps{
    NSMutableString *namez = [NSMutableString string];
    for (int i=0; i<[[Singleton sharedMySingleton].NamesForRequestInMap count]; i++) {
        NSString *name = [NSString stringWithFormat:@"%@;",[[Singleton sharedMySingleton].NamesForRequestInMap objectAtIndex:i]];
        [name substringToIndex:[name length]-1];
        [namez appendString:name];
    }
    if ([[Singleton sharedMySingleton].NamesForRequestInMap count]==0) {
        [namez appendString:AllPodcategories];
    }
    NSString *url = [NSString stringWithFormat:@"http://work.hypermarka.com/hm/svc-shoplist?list=%@&swlat=56.4922648749152&swlng=52.202664648437505&nelat=57.24433849873821&nelng=54.2351353515625", namez];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:15];
    request.HTTPMethod=PostMethod;
    NSError* connectionError=nil;
    NSHTTPURLResponse* response=nil;
    NSData *data =[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&connectionError];
    if (!response.statusCode) {
        NSLog(@"Проблема соеденения с сервером");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Отсутствует соеденение с сетью интернет, пожалуйста, подключите интернет и повторите попытку"
                                                       delegate:self
                                              cancelButtonTitle:@"ОК"
                                              otherButtonTitles:nil];
        [alert show];
    }
    return data;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        UIStoryboard *storyboard = self.storyboard;
        MapDownloads *finished = [storyboard instantiateViewControllerWithIdentifier:@"ConnectionError"];
        
        [self presentViewController:finished animated:YES completion:NULL];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
