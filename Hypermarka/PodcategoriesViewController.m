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
@synthesize NavigationBar;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.TitleNavigation.title = [Singleton sharedMySingleton].TextLabelCell;
    if ([self.TitleNavigation.title  isEqual: @"Стройка и ремонт"]) {
        NSLog(@"ALLRIGHT");
    }
    else{
        UIStoryboard *storyboard = self.storyboard;
        PodcategoriesViewController *finished = [storyboard instantiateViewControllerWithIdentifier:@"404error"];
        
        [self presentViewController:finished animated:YES completion:NULL];
    }
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    UIDeviceOrientation orientation1 = [[UIDevice currentDevice] orientation];
    [Singleton sharedMySingleton].orientation = orientation1;
         
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    NSLog(@"Height = %f, width = %f", screenBounds.size.height, screenBounds.size.width);
         if ([Singleton sharedMySingleton].width == 0) {
             if (orientation1 == UIDeviceOrientationLandscapeLeft) {
                 NSLog(@"Кнопка Home справа (Альбомная ориентация) высоту и ширину надо поменять");
                 [Singleton sharedMySingleton].height = screenBounds.size.width;
                 [Singleton sharedMySingleton].width = screenBounds.size.height;
             }else if (orientation1 == UIDeviceOrientationLandscapeRight){
                 NSLog(@"Кнопка Home слева (Альбомная ориентация) высоту и ширину надо поменять");
                 [Singleton sharedMySingleton].height = screenBounds.size.width;
                 [Singleton sharedMySingleton].width = screenBounds.size.height;
             }else if (orientation1 == UIDeviceOrientationPortrait){
                 NSLog(@"Кнопка Home снизу (Портретная ориенация) высоту и ширину менять не надо");
                 [Singleton sharedMySingleton].height = screenBounds.size.height;
                 [Singleton sharedMySingleton].width = screenBounds.size.width;
             }else if (orientation1 == UIDeviceOrientationPortraitUpsideDown){
                 NSLog(@"Кнопка Home сверху (Портретная ориенация) высоту и ширину менять не надо");
                 [Singleton sharedMySingleton].height = screenBounds.size.height;
                 [Singleton sharedMySingleton].width = screenBounds.size.width;
             }else{
                 NSLog(@"неопределена ориентация");
                 [Singleton sharedMySingleton].height = screenBounds.size.height;
                 [Singleton sharedMySingleton].width = screenBounds.size.width;}
             
         }
         else {
             NSLog(@"Ориентация неопределена");
         }
         NSLog(@"TableViewController");
         NSString *path  = [[NSBundle mainBundle] pathForResource:@"ExpansionTableTestData2" ofType:@"plist"];
         _dataList = [[NSMutableArray alloc] initWithContentsOfFile:path];
         
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
         NSString *test = self.restorationIdentifier;
         if ([test  isEqual: @"CategoriesViewController"]) {
             self.cat = YES;
         }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
         
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        int count;
        count = [[Singleton sharedMySingleton].Titles count];
        return count;
    }
         
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        if (self.isOpen) {
            if (self.selectIndex.section == section) {
                NSMutableArray *TitleList = [[Singleton sharedMySingleton].podsections valueForKey:@"title"];
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
            NSString *name = [NSString string];
            if (self.cat) {
                name = [self.tableData objectAtIndex:indexPath.section];
                cell.arrowImageView.image = nil;
                [cell.titleLabel setFont:[UIFont systemFontOfSize:16]];
            }
            else{
                name = [[[Singleton sharedMySingleton].Titles objectAtIndex:indexPath.section]capitalizedString];
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
                   
        }
    }
                
}


         
         
- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
    {
        self.isOpen = firstDoInsert;
        
        Cell1 *cell = (Cell1 *)[self.expansionTableView cellForRowAtIndexPath:self.selectIndex];
        [cell changeArrowWithUp:firstDoInsert];
        
        [self.expansionTableView beginUpdates];
        
        NSMutableArray *TitleList = [[Singleton sharedMySingleton].podsections valueForKey:@"title"];
        NSLog(@"Titlelist: %@", TitleList);
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


- (IBAction)BackButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
