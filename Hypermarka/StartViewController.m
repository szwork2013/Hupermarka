//
//  StartViewController.m
//  Hypermarka
//
//  Created by Bogdan on 12.05.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController
@synthesize internet;

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
   
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    internet = YES;
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if (status == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Отсутствует соеденение с сетью интернет, пожалуйста, подключите интернет и повторите попытку"
                                                       delegate:self
                                              cancelButtonTitle:@"ОК"
                                              otherButtonTitles:nil];
        [alert show];
        internet = NO;
    }
    else{
    [Singleton sharedMySingleton].AllOpetarions = [NSOperationQueue new];

    NSOperation *DownloadOperation = [NSOperation new];
    DownloadOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(DownloadAndParse:) object:nil];
    
    [[Singleton sharedMySingleton].AllOpetarions addOperation:DownloadOperation];
    }
}


-(void)DownloadAndParse:(NSURL *)url{
    StartDownloads *sd = [[StartDownloads alloc] init];
    NSData* Data = [sd data];
    NSError *error;
    NSMutableDictionary *DataDict = [NSJSONSerialization
                                     JSONObjectWithData:Data
                                     options:NSJSONReadingMutableContainers
                                     error:&error];
    
    NSMutableArray *AllSection = [DataDict objectForKey:@"section"];
    NSMutableArray *Titles = [NSMutableArray array];
    NSMutableArray *Titles2 = [NSMutableArray array];
    NSMutableArray *list = [NSMutableArray array];
    NSMutableArray *list2 = [NSMutableArray array];
    NSMutableArray *names = [NSMutableArray array];
    NSMutableArray *names2 = [NSMutableArray array];
    NSMutableArray *ids = [NSMutableArray array];
    for (int i=0; i<[AllSection count]; i++) {
        [Titles addObject:[[AllSection objectAtIndex:i] valueForKey:TitleKey]];
        [list addObject: [[AllSection objectAtIndex:i] valueForKey:@"section"]];
        [names addObject:[[AllSection objectAtIndex:i] valueForKey:NameKey]];
        [ids addObject:[[AllSection objectAtIndex:i] valueForKey:SaitIdKey]];
        if ([[[AllSection objectAtIndex:i] valueForKey:SaitIdKey] isEqualToString:StroySectionId]) {
            [Titles2 addObject:[[AllSection objectAtIndex:i] valueForKey:TitleKey]];
            [list2 addObject:[[AllSection objectAtIndex:i] valueForKey:@"section"]];
            [names2 addObject:[[AllSection objectAtIndex:i] valueForKey:NameKey]];
        }
    }
    [Singleton sharedMySingleton].TitlesForAllPodsection = Titles;
    [Singleton sharedMySingleton].AllPodPodsection = list;
    [Singleton sharedMySingleton].TitlesForPodsectionInStroySection = Titles2;
    [Singleton sharedMySingleton].PodPodSectionForStroySection = list2;
}

-(void)viewDidAppear:(BOOL)animated{
    if (internet) {
        UIStoryboard *storyboard = self.storyboard;
        StartViewController *finished = [storyboard instantiateViewControllerWithIdentifier:@"rootController"];
        [self presentViewController:finished animated:NO completion:NULL];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
