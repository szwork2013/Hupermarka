//
//  CatalogViewController.m
//  Hypermarka
//
//  Created by Bogdan Redkin on 04.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "CatalogViewController.h"
#define WithoutImagesCell @"MyCell2"
#define WithImagesCell @"MyCell"

@interface CatalogViewController ()

@end

@implementation CatalogViewController

@synthesize Shops, Prices, Titles, Images,  NivigationTitle, CatTableView, downloadImage, info, number;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if (status == ReachableViaWiFi)
    {
        downloadImage = YES;
    }
    else if (status == ReachableViaWWAN)
    {
        downloadImage = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Мобильное интернет соеденение.\n Отображать картинки?."
                                                       delegate:self
                                              cancelButtonTitle:@"Да"
                                              otherButtonTitles:@"Нет", nil];
        [alert show];
    }

    [ProgressHUD show:@"Загрузка данных"];
    NSOperation *DownloadOperation = [NSOperation new];
    DownloadOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(DownloadAndParse:) object:nil];
    [[Singleton sharedMySingleton].AllOpetarions addOperation:DownloadOperation];

    CatalogDownloads *cd = [[CatalogDownloads alloc] init];
    NSData *data = [cd DataDownloads];
    NSError *error;
    NSMutableArray *DataDict = [NSJSONSerialization
                                JSONObjectWithData:data
                                options:NSJSONReadingMutableContainers
                                error:&error];
    NivigationTitle.title = [Singleton sharedMySingleton].TitleForNavigationBar;
    NSMutableArray *SVC = [DataDict valueForKey:@"svc"];
    number = 0;
    if (!self.Titles) {
        self.Titles = [NSMutableArray array];
    }
    if (!self.Images) {
        self.Images = [NSMutableArray array];
    }
    if (!self.ImagesNames) {
        self.ImagesNames = [NSMutableArray array];
    }
    if (!self.info) {
        self.info = [NSMutableArray array];
    }
    if (![Singleton sharedMySingleton].DataForInfoView) {
        [Singleton sharedMySingleton].DataForInfoView = [NSMutableArray array];
    }
    self.Images = [[SVC valueForKey:ImageKey] objectAtIndex:0];
    for (int i = 0; i<[self.Images count]; i++) {
        
        if ([self.Images objectAtIndex:i] == [NSNull null]) {
            [self.ImagesNames addObject:@"http://work.hypermarka.com/images/site/foto.gif"];
        }
        else{
            [self.ImagesNames addObject:[NSString stringWithFormat:@"http://work.hypermarka.com/res_ru/%@", [[self.Images objectAtIndex:i] valueForKey:@"name"]]];
        }
    }
    self.Titles = [[SVC valueForKey:TitleKey] objectAtIndex:0];
    self.Prices = [[SVC valueForKey:PriceKey] objectAtIndex:0];
    self.info = [SVC valueForKey:DescriptionKey];
    self.CatTableView.rowHeight = 150;
}
-(void)DownloadAndParse:(NSURL *)url{

}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        downloadImage = YES;
    }
    else if(buttonIndex == 1){
        downloadImage = NO;
    }
}
-(void)DownloadAndParse{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.Titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MyCell *cell = (MyCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (downloadImage) {
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:WithImagesCell owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.name.text = [Titles objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:[self.ImagesNames objectAtIndex:indexPath.row]];
        cell.photo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        NSString *message = [NSString stringWithFormat:@"Загрузка картинки %i из %i", indexPath.row+1, [self.Titles count]];
        if (indexPath.row+1 == [self.Titles count]) {
            [ProgressHUD showSuccess:nil];
        }
        else{
            [ProgressHUD show:message];
        }
        cell.photo.contentMode = UIViewContentModeScaleAspectFit;
        cell.Price.text = [[self.Prices objectAtIndex:indexPath.row] valueForKey:RublesKey];
        cell.Shop.text = [Singleton sharedMySingleton].TitleForShopInCatalog;
    }
    else {
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:WithoutImagesCell owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.name.text = [Titles objectAtIndex:indexPath.row];
        cell.Price.text = [[self.Prices objectAtIndex:indexPath.row] valueForKey:RublesKey];
        cell.Shop.text = [Singleton sharedMySingleton].TitleForShopInCatalog;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [Singleton sharedMySingleton].TitleForInfoView = [Titles objectAtIndex:indexPath.row];
    if ([self.info count]>indexPath.row) {
        [Singleton sharedMySingleton].DataForInfoView = [self.info objectAtIndex:indexPath.row];
        [Singleton sharedMySingleton].imageURL = [self.ImagesNames objectAtIndex:indexPath.row];
        [Singleton sharedMySingleton].priceForElementsOfCatalog = [[self.Prices objectAtIndex:indexPath.row] valueForKey:RublesKey];
    }
    else {
        [Singleton sharedMySingleton].DataForInfoView = nil;
        [Singleton sharedMySingleton].imageURL = nil;
        [Singleton sharedMySingleton].priceForElementsOfCatalog = nil;
    }
    UIViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoViewController"];
    [self.navigationController pushViewController: myController animated:YES];
}

@end
