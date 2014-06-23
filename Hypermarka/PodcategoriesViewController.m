//
//  PodcategoriesViewController.m
//  Hypermarka
//
//  Created by Bogdan Redkin on 04.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "PodcategoriesViewController.h"
#import "Cell1.h"
#import "Cell2.h"

@interface PodcategoriesViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_dataList;
    
}
@property (assign)BOOL isOpen;
@property (assign)BOOL cat;
@property (nonatomic,strong)NSIndexPath *selectIndex;

@property (nonatomic,strong)IBOutlet UITableView *expansionTableView;

@end

@implementation PodcategoriesViewController
@synthesize isOpen,selectIndex, arSelectedIndexPaths, CellIndexPathes, lists;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc
{
    _dataList = nil;
    self.isOpen = NO;
    self.cat = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [ProgressHUD dismiss];
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
    if (![Singleton sharedMySingleton].NamesForRequestInMap) {
        [Singleton sharedMySingleton].NamesForRequestInMap = [NSMutableArray array];
        }
    NSString *test = self.restorationIdentifier;
    if ([test  isEqual: @"CategoriesViewController"]) {
        self.cat = YES;
        }
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source
         
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        int count;
        count = [[Singleton sharedMySingleton].TitlesForPodsectionInStroySection count];
        return count;
    }
         
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        if (self.isOpen) {
            if (self.selectIndex.section == section) {
                NSMutableArray *TitleList = [[Singleton sharedMySingleton].PodPodSectionForStroySection valueForKey:TitleKey];
                return [[TitleList objectAtIndex:section] count]+1;;
        }
    }
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
            
            NSMutableArray *TitleList = [[Singleton sharedMySingleton].PodPodSectionForStroySection valueForKey:TitleKey];
            NSMutableArray *NamesList = [[Singleton sharedMySingleton].PodPodSectionForStroySection valueForKey:NameKey];
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
            NSString *name = [NSString string];
            if (self.cat) {
                name = [self.tableData objectAtIndex:indexPath.section];
                cell.arrowImageView.image = nil;
                [cell.titleLabel setFont:[UIFont systemFontOfSize:16]];
            }
            else{
                name = [[[Singleton sharedMySingleton].TitlesForPodsectionInStroySection objectAtIndex:indexPath.section]capitalizedString];
            }
            cell.titleLabel.text = name;
            if (self.cat) {
            }
            else{
                [cell changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
            }
            return cell;
        }
    }
         
         
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
            if (indexPath.row == 0) {
                if ([indexPath isEqual:self.selectIndex]) {
                    self.isOpen = NO;
                    [self didSelectCellRowFirstDo:NO nextDo:NO];
                    self.selectIndex = nil;
                    
                }else
                {
                    if (!self.selectIndex) {
                        self.selectIndex = indexPath;
                        [self didSelectCellRowFirstDo:YES nextDo:NO];
                        
                    }else
                    {
                        
                        [self didSelectCellRowFirstDo:NO nextDo:YES];
                    }
                }
                
            }else
            {
                if (isOpen) {
                    NSMutableArray *NamesList = [[Singleton sharedMySingleton].PodPodSectionForStroySection valueForKey:NameKey];
                    NSMutableArray *TitleList = [[Singleton sharedMySingleton].PodPodSectionForStroySection valueForKey:TitleKey];
                    NSString *SelectedString = [NSString stringWithString:[[NamesList objectAtIndex:indexPath.section]objectAtIndex:indexPath.row-1]];
                    NSString *SelectedTitle = [NSString stringWithString:[[TitleList objectAtIndex:indexPath.section]objectAtIndex:indexPath.row-1]];
                    [Singleton sharedMySingleton].NamesForRequestInCatalog =SelectedString;
                    [Singleton sharedMySingleton].TitleForNavigationBar = SelectedTitle;
                    UIViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"CatalogViewController"];
                    [self.navigationController pushViewController: myController animated:YES];
                    
        }
    }
                
}


         
         
- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
    {
        self.isOpen = firstDoInsert;
        
        Cell1 *cell = (Cell1 *)[self.expansionTableView cellForRowAtIndexPath:self.selectIndex];
        [cell changeArrowWithUp:firstDoInsert];
        
        [self.expansionTableView beginUpdates];
        
        NSMutableArray *TitleList = [[Singleton sharedMySingleton].PodPodSectionForStroySection valueForKey:TitleKey];
        int section = self.selectIndex.section;
        
        int contentCount = [[TitleList objectAtIndex:section] count];
        NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
        if (contentCount>0) {
            for (NSUInteger i = 1; i < contentCount + 1; i++) {
                NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
                [rowToInsert addObject:indexPathToInsert];
            }
        }
        
        if (firstDoInsert)
        {   [self.expansionTableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        else
        {
            [self.expansionTableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        }
        
        
        [self.expansionTableView endUpdates];
        if (nextDoInsert) {
            self.isOpen = YES;
            self.selectIndex = [self.expansionTableView indexPathForSelectedRow];
            [self didSelectCellRowFirstDo:YES nextDo:NO];
        }
        if (self.isOpen) [self.expansionTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    }



@end
