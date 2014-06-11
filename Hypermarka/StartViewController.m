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
    NSLog(@"StartViewController");
    [super viewDidLoad];
//    загрузка данных
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    UIDeviceOrientation orientation1 = [[UIDevice currentDevice] orientation];
    [Singleton sharedMySingleton].orientation = orientation1;
    [Singleton sharedMySingleton].FilterOpen = NO;

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if ([Singleton sharedMySingleton].width == 0) {
        if (orientation1 == UIDeviceOrientationLandscapeLeft) {
            [Singleton sharedMySingleton].height = screenBounds.size.width;
            [Singleton sharedMySingleton].width = screenBounds.size.height;
        }else if (orientation1 == UIDeviceOrientationLandscapeRight){
            [Singleton sharedMySingleton].height = screenBounds.size.width;
            [Singleton sharedMySingleton].width = screenBounds.size.height;
        }else if (orientation1 == UIDeviceOrientationPortrait){
            [Singleton sharedMySingleton].height = screenBounds.size.height;
            [Singleton sharedMySingleton].width = screenBounds.size.width;
        }else if (orientation1 == UIDeviceOrientationPortraitUpsideDown){
            [Singleton sharedMySingleton].height = screenBounds.size.height;
            [Singleton sharedMySingleton].width = screenBounds.size.width;
        }else{
            [Singleton sharedMySingleton].height = screenBounds.size.height;
            [Singleton sharedMySingleton].width = screenBounds.size.width;}
        
    }
    else {
    }
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    NSURL *url = [NSURL URLWithString:@"http://work.hypermarka.com/hm/proto/secview?obj=0"];
    NSOperation *DownloadOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(DownloadAndParse:) object:url];
    
    [queue addOperation:DownloadOperation];
    
    UIBarButtonItem *buttonizeButton = [[UIBarButtonItem alloc] initWithTitle:@"Buttonize"
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(buttonizeButtonTap:)];
    self.navigationItem.rightBarButtonItems = @[buttonizeButton];

}
-(void)buttonizeButtonTap:(id)sender{
    [self performSegueWithIdentifier:@"Associate" sender:sender];
}
-(void)DownloadAndParse:(NSURL *)url{
    NSData *allCoursesData = [[NSData alloc] initWithContentsOfURL:url];
    NSString *allData = [[NSString alloc] initWithData:allCoursesData encoding:NSUTF8StringEncoding];
    //    парсинг оных
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{

}
- (void)didRotate:(NSNotification *)notification{
    
    UIDeviceOrientation orientation1 = [[UIDevice currentDevice] orientation];
    [Singleton sharedMySingleton].orientation = orientation1;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    
    if (orientation1 == UIDeviceOrientationLandscapeLeft) {
        [Singleton sharedMySingleton].height = screenBounds.size.width;
        [Singleton sharedMySingleton].width = screenBounds.size.height;
    }else if (orientation1 == UIDeviceOrientationLandscapeRight){
        [Singleton sharedMySingleton].height = screenBounds.size.width;
        [Singleton sharedMySingleton].width = screenBounds.size.height;
    }else if (orientation1 == UIDeviceOrientationPortrait){
        [Singleton sharedMySingleton].height = screenBounds.size.height;
        [Singleton sharedMySingleton].width = screenBounds.size.width;
    }else if (orientation1 == UIDeviceOrientationPortraitUpsideDown){
        [Singleton sharedMySingleton].height = screenBounds.size.height;
        [Singleton sharedMySingleton].width = screenBounds.size.width;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    UIStoryboard *storyboard = self.storyboard;
    StartViewController *finished = [storyboard instantiateViewControllerWithIdentifier:@"CategoriesViewController"];
    [self presentViewController:finished animated:YES completion:NULL];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
