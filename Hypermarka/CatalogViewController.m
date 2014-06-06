//
//  CatalogViewController.m
//  Hypermarka
//
//  Created by Bogdan Redkin on 04.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "CatalogViewController.h"

@interface CatalogViewController ()

@end

@implementation CatalogViewController

@synthesize Shops, Prices, Titles, Images,  NivigationTitle, CatTableView;

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
    NSLog(@"Name: %@", [Singleton sharedMySingleton].SelectedName);
    NSData *allCoursesData = [[NSData alloc] initWithContentsOfURL:
                              [NSURL URLWithString:@"http://work.hypermarka.com/hm/proto-showcase?shop=0&sort=price&section=stroy&subsection=electroinstrument&pg=all&theme=11"]];
    
    NSString *allData = [[NSString alloc] initWithData:allCoursesData encoding:NSUTF8StringEncoding];
    //    парсинг оных
    NSMutableString *mutableData = [NSMutableString stringWithString:allData];
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
    [mutableData insertString:@"}" atIndex:mutableData.length-2];
    NSString *DataStr = [NSString stringWithString:mutableData];
    NSData *data = [DataStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSMutableArray *DataDict = [NSJSONSerialization
                                     JSONObjectWithData:data
                                     options:NSJSONReadingMutableContainers
                                     error:&error];
    NSString *NavigationTitle = [NSString stringWithFormat:@"%@", [[DataDict valueForKey:@"title"] objectAtIndex:0]];
    NivigationTitle.title = NavigationTitle;
    
    NSMutableArray *SVC = [DataDict valueForKey:@"svc"];
    self.Titles = [SVC valueForKey:@"title"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    cell.textLabel.text = @"123";
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [indexPath row] * 5;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
