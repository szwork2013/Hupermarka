//
//  CatalogDownloads.m
//  Hypermarka
//
//  Created by Bogdan Redkin on 20.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "CatalogDownloads.h"

@interface CatalogDownloads ()

@end

@implementation CatalogDownloads

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

-(NSData *)DataDownloads{
    NSString *StringUrl = [NSString string];
    NSData *allData = [NSData data];
      if ([Singleton sharedMySingleton].AfterMap) {
        StringUrl = [NSString stringWithFormat:@"http://work.hypermarka.com/hm/proto-showcase?shop=%@&sort=price&section=stroy&subsection=%@&pg=all&theme=11",[Singleton sharedMySingleton].SelectedShopId, [Singleton sharedMySingleton].NamesForRequestInCatalog];
    }
    else{
        StringUrl = [NSString stringWithFormat:@"http://work.hypermarka.com/hm/proto-showcase?shop=0&sort=price&section=stroy&subsection=%@&pg=all&theme=11", [Singleton sharedMySingleton].NamesForRequestInCatalog];
    }
    NSData *data = [[NSData alloc] init];
    NSURL *url = [NSURL URLWithString:StringUrl];
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
    else{
    NSString *allDataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableString *mutableData = [NSMutableString stringWithString:allDataString];
    int c = 0;
    for (int i=0;i<mutableData.length ; i++) {
        NSString *element = [mutableData substringWithRange:NSMakeRange(i, 1)];
        if ([element isEqualToString:@"}"]) {
            if (c == 0) {
                [mutableData deleteCharactersInRange:NSMakeRange(i, 1)];
            }
            c++;
        }
    }
    int a = [mutableData length]-2;
    [mutableData replaceCharactersInRange:NSMakeRange(a, 1) withString:@"}"];
    [mutableData replaceCharactersInRange:NSMakeRange([mutableData length]-1,1)  withString:@"]"];
        
    NSString *DataStr = [NSString stringWithString:mutableData];
    allData = [DataStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    return allData;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        UIStoryboard *storyboard = self.storyboard;
        CatalogDownloads *finished = [storyboard instantiateViewControllerWithIdentifier:@"ConnectionError"];
        
        [self presentViewController:finished animated:YES completion:NULL];
    }
}
@end
