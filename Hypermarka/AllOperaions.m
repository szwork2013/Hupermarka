//
//  AllOperaions.m
//  Hypermarka
//
//  Created by Bogdan Redkin on 17.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "AllOperaions.h"

@interface AllOperaions ()

@end

@implementation AllOperaions

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
//загрузка из Start View Controller
-(void)DownloadAndParse:(NSURL *)url{
    NSLog(@"StartViewControllerDownload");
    NSData *allCoursesData = [[NSData alloc] initWithContentsOfURL:url];
    NSString *allData = [[NSString alloc] initWithData:allCoursesData encoding:NSUTF8StringEncoding];
    NSMutableString *mutableData = [NSMutableString stringWithString:allData];
    
    [mutableData replaceCharactersInRange:NSMakeRange(0, 1) withString:@"{"];
    int a = [mutableData length]-2;
    [mutableData replaceCharactersInRange:NSMakeRange(a, 1) withString:@"}"];
    NSString *DataStr = [NSString stringWithString:mutableData];
    NSData *data = [DataStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSMutableDictionary *DataDict = [NSJSONSerialization
                                     JSONObjectWithData:data
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
        [Titles addObject:[[AllSection objectAtIndex:i] valueForKey:@"title"]];
        [list addObject: [[AllSection objectAtIndex:i] valueForKey:@"section"]];
        [names addObject:[[AllSection objectAtIndex:i] valueForKey:@"name"]];
        [ids addObject:[[AllSection objectAtIndex:i] valueForKey:@"sait_id"]];
        if ([[[AllSection objectAtIndex:i] valueForKey:@"sait_id"] isEqualToString: @"402"]) {
            [Titles2 addObject:[[AllSection objectAtIndex:i] valueForKey:@"title"]];
            [list2 addObject:[[AllSection objectAtIndex:i] valueForKey:@"section"]];
            [names2 addObject:[[AllSection objectAtIndex:i] valueForKey:@"name"]];
        }
    }
    [Singleton sharedMySingleton].Titles = Titles;
    [Singleton sharedMySingleton].podsections = list;
    [Singleton sharedMySingleton].Titles2 = Titles2;
    [Singleton sharedMySingleton].podsections2 = list2;
    [Singleton sharedMySingleton].names2 = names2;
}

@end
