//
//  ShopsViewController.m
//  Hypermarka
//
//  Created by Bogdan Redkin on 09.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "ShopsViewController.h"

@interface ShopsViewController ()

@end

@implementation ShopsViewController
@synthesize NavTitle;
@synthesize Shops, Prices, Titles, Images, CatTableView;

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
    NavTitle.title = [Singleton sharedMySingleton].InfoTitle;  NSLog(@"Name: %@", [Singleton sharedMySingleton].SelectedName);
    NSString *url = [NSString stringWithFormat:@"http://work.hypermarka.com/hm/proto-showcase?shop=0&sort=price&section=stroy&subsection=%@&pg=all&theme=11", [Singleton sharedMySingleton].SelectedName];
    NSData *allCoursesData = [[NSData alloc] initWithContentsOfURL:
                              [NSURL URLWithString:url]];
    
    NSString *allData = [[NSString alloc] initWithData:allCoursesData encoding:NSUTF8StringEncoding];
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
    
    NSMutableArray *SVC = [DataDict valueForKey:@"svc"];
    if (!self.Titles) {
        self.Titles = [NSMutableArray array];
    }
    if (!self.Images) {
        self.Images = [NSMutableArray array];
    }
    if (!self.ImagesNames) {
        self.ImagesNames = [NSMutableArray array];
    }
    
    self.Images = [[SVC valueForKey:@"image"] objectAtIndex:0];
    for (int i = 0; i<[self.Images count]; i++) {
        
        if ([self.Images objectAtIndex:i] == [NSNull null]) {
            [self.ImagesNames addObject:@"http://work.hypermarka.com/images/site/foto.gif"];
        }
        else{
            [self.ImagesNames addObject:[NSString stringWithFormat:@"http://work.hypermarka.com/res_ru/%@", [[self.Images objectAtIndex:i] valueForKey:@"name"]]];
        }
    }
    
    self.Titles = [[SVC valueForKey:@"title"] objectAtIndex:0];
    self.Prices = [[SVC valueForKey:@"price"] objectAtIndex:0];
    self.CatTableView.rowHeight = 150;
    
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
    if (cell == nil) {
        //если ячейка не найдена - создаем новую
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
	}
    
    cell.name.text = [Titles objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:[self.ImagesNames objectAtIndex:indexPath.row]];
    cell.photo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    cell.photo.contentMode = UIViewContentModeScaleAspectFit;
    cell.Price.text = [[self.Prices objectAtIndex:indexPath.row] valueForKey:@"RUR"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor whiteColor
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)BackButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
    [Singleton sharedMySingleton].close = YES;
}
@end
