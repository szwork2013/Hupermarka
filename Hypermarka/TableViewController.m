//
//  DiYuListViewController.m
//  IYLM
//
//  Created by Jian-Ye on 12-10-30.
//  Copyright (c) 2012年 Jian-Ye. All rights reserved.
//

#import "TableViewController.h"
#import "Cell1.h"
#import "Cell2.h"
@interface TableViewController()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataList;
    
}
@property (assign)BOOL isOpen;
@property (assign)BOOL cat;
@property (nonatomic,strong)NSIndexPath *selectIndex;

@property (nonatomic,strong)IBOutlet UITableView *expansionTableView;
@end

@implementation TableViewController
@synthesize isOpen,selectIndex, arSelectedIndexPaths, CellIndexPathes, lists;

- (void)dealloc
{
    _dataList = nil;
    self.isOpen = NO;
    self.cat = NO;
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
    if (![Singleton sharedMySingleton].NamesForRequestInMap) {
        [Singleton sharedMySingleton].NamesForRequestInMap = [NSMutableArray array];
    }
    if (![Singleton sharedMySingleton].SelectedIndexesForTableViewController) {
        [Singleton sharedMySingleton].SelectedIndexesForTableViewController = [NSMutableArray array];
    }
    NSString *test = self.restorationIdentifier;
    if ([test  isEqual: @"CategoriesViewController"]) {
        self.cat = YES;
    }
    if (!self.tableData) {
        self.tableData = [NSMutableArray arrayWithObjects:@"Стройка и ремонт", @"Товары для дома и офиса, мебель", @"Одежда и обувь", @"Спортивные товары и питание, фитнес клубы", @"Парфюмерия, косметика и бытовая химия", @"Турагенства и билеты", @"Сумки, чемоданы, кожгалантерея", @"Учебные заведения", @"Бытовая и офисная техника", @"Рыбалка и охота, базы отдыха", @"Досуг, рестораны, дискотеки, кинотеатры", @"Связь, ТВ, интернет", @"Медицинские учреждения, Аптеки", @"Зоомагазины, корма для животных, ветеринарные служба", @"Услуги", @"Продукты питания и напитки", @"Банки, финансовые учреждения, страховые компании", @"Автомобили, автошколы", @"Книги, учебники", @"Салоны красоты, молодые мамы", @"Антиквариат, ломбард, скупка", @"Ремонт, Ателье1", nil];

    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int count;
    if (self.cat) {
        count = [self.tableData count];
    }
    else{
        count = [[Singleton sharedMySingleton].TitlesForAllPodsection count];
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOpen) {
        if (self.selectIndex.section == section) {
            NSMutableArray *TitleList = [[Singleton sharedMySingleton].AllPodPodsection valueForKey:TitleKey];
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
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        if ([[Singleton sharedMySingleton].SelectedIndexesForTableViewController containsObject:indexPath]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        NSMutableArray *TitleList = [[Singleton sharedMySingleton].AllPodPodsection valueForKey:TitleKey];
        NSMutableArray *NamesList = [[Singleton sharedMySingleton].AllPodPodsection valueForKey:NameKey];
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
        name = [[[Singleton sharedMySingleton].TitlesForAllPodsection objectAtIndex:indexPath.section]capitalizedString];
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
    if (self.cat) {
        UIViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"PodcategoriesViewController"];
        [self.navigationController pushViewController: myController animated:YES];
    }
    else{
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
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (cell.accessoryType == UITableViewCellAccessoryNone) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                int row = indexPath.row;
                int section = indexPath.section;
                [[Singleton sharedMySingleton].SelectedIndexesForTableViewController addObject:[NSIndexPath indexPathForRow:row inSection:section]];
                [[Singleton sharedMySingleton].NamesForRequestInMap addObject:[lists objectAtIndex:indexPath.row-1]];
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryNone;
                int row = indexPath.row;
                int section = indexPath.section;
                [[Singleton sharedMySingleton].SelectedIndexesForTableViewController removeObject:[NSIndexPath indexPathForRow:row inSection:section]];
                [[Singleton sharedMySingleton].NamesForRequestInMap removeObject:[lists objectAtIndex:indexPath.row-1]];
            }
        }

    }
    for (int i = 0; i<[[Singleton sharedMySingleton].SelectedIndexesForTableViewController count]; i++) {
        NSIndexPath *CustomIndexPath = [[Singleton sharedMySingleton].SelectedIndexesForTableViewController objectAtIndex:i];
        CellIndexPathes = [tableView cellForRowAtIndexPath:CustomIndexPath];
        CellIndexPathes.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}
}


- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    
    
    Cell1 *cell = (Cell1 *)[self.expansionTableView cellForRowAtIndexPath:self.selectIndex];
    [cell changeArrowWithUp:firstDoInsert];
    
    [self.expansionTableView beginUpdates];
    
    NSMutableArray *TitleList = [[Singleton sharedMySingleton].AllPodPodsection valueForKey:TitleKey];
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

-(IBAction)BarButton:(id)sender{
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];

}
@end
