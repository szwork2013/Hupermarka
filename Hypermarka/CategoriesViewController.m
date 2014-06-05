//
//  DiYuListViewController.m
//  IYLM
//
//  Created by Jian-Ye on 12-10-30.
//  Copyright (c) 2012年 Jian-Ye. All rights reserved.
//

#import "CategoriesViewController.h"
#import "Cell1.h"
#import "Cell2.h"
@interface CategoriesViewController()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataList;
    
}
@property (assign)BOOL isOpen;
@property (nonatomic,strong)NSIndexPath *selectIndex;

@property (nonatomic,strong)IBOutlet UITableView *expansionTableView;
@end

@implementation CategoriesViewController
@synthesize isOpen,selectIndex, arSelectedIndexPaths, CellIndexPathes, lists;

- (void)dealloc
{
    _dataList = nil;
    self.isOpen = NO;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.expansionTableView.sectionFooterHeight = 0;
    self.expansionTableView.sectionHeaderHeight = 0;
    self.isOpen = NO;
    if (!arSelectedIndexPaths) {
        arSelectedIndexPaths = [NSMutableArray array];
    }
    if (!lists) {
        lists = [NSMutableArray array];
    }
    if (![Singleton sharedMySingleton].names) {
        [Singleton sharedMySingleton].names = [NSMutableArray array];
    }
    if (![Singleton sharedMySingleton].SelectedIndexes) {
        [Singleton sharedMySingleton].SelectedIndexes = [NSMutableArray array];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[Singleton sharedMySingleton].Titles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return 1;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0) {
        static NSString *CellIdentifier = @"Cell2";
        Cell2 *cell = (Cell2*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        
        NSMutableArray *TitleList = [[Singleton sharedMySingleton].podsections valueForKey:@"title"];
        NSMutableArray *NamesList = [[Singleton sharedMySingleton].podsections valueForKey:@"name"];
        NSMutableArray *list = [TitleList objectAtIndex:self.selectIndex.section];
        cell.titleLabel.text = [list objectAtIndex:indexPath.row-1];
        lists = [NamesList objectAtIndex:self.selectIndex.section];
        return cell;
    }else
    {
        static NSString *CellIdentifier = @"Cell1";
        Cell1 *cell = (Cell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        NSString *name = [[[Singleton sharedMySingleton].Titles objectAtIndex:indexPath.section] capitalizedString];
        cell.titleLabel.text = name;
        return cell;
    }
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"Click!");
}





@end
