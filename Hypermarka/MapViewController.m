//
//  MapViewController.m
//  test4
//
//  Created by Bogdan Redkin on 11.03.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "MapViewController.h"
#import "Singleton.h"
#import "REVClusterMap.h"
#import "REVClusterAnnotationView.h"
#define districtSpan MKCoordinateSpanMake(0.008978, 0.014324)
#define citySpan MKCoordinateSpanMake(0.102967, 0.101562)
#define IzhveskCoordinate CLLocationCoordinate2DMake(56.844935, 53.225970)
#define BASE_RADIUS .1
#define MINIMUM_LATITUDE_DELTA 0.20
#define BLOCKS 4
#define MINIMUM_ZOOM_LEVEL 200000

@interface MapViewController ()


@end

@implementation MapViewController


@synthesize AnnTitles, IDS, OriginalTitles;

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
    
    _mapView.delegate = self;
    
    
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [_mapView setRegion:MKCoordinateRegionMake(IzhveskCoordinate, citySpan) animated:YES];
    md = [[MapDownloads alloc] init];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSData *Data = [md DataForMaps];
    receivedData = [NSMutableData dataWithData:Data];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
    NSArray *metka = [json objectForKey:@"metka"];
    NSArray *addresses = [metka valueForKey:@"address"];
    NSArray *lat = [metka valueForKey:@"lat"];
    NSArray *lon = [metka valueForKey:@"lon"];
    OriginalTitles = [metka valueForKey:@"name"];
    NSArray *worktime = [metka valueForKey:@"worktime"];
    IDS = [metka valueForKey:@"shop_id"];
    long Ncount = [OriginalTitles count];
    NSMutableArray *pins = [NSMutableArray array];
    
    
    for (int i = 0; i<Ncount; i++) {
        NSString *titles =[NSString stringWithFormat:@"%@ (%@)", [addresses objectAtIndex:i], [OriginalTitles objectAtIndex:i]];
        [AnnTitles addObject:titles];
        NSString *subtitles = [NSString stringWithFormat:@"Режим работы: %@", [worktime objectAtIndex:i]];
        CGFloat X = [[lat objectAtIndex:i] floatValue];
        CGFloat Y = [[lon objectAtIndex:i] floatValue];
        
        CLLocationCoordinate2D newCoord = {X, Y};
        
        REVClusterPin *pin = [[REVClusterPin alloc] init];
        pin.title = titles;
        pin.subtitle = subtitles;
        pin.coordinate = newCoord;
        
        [pins addObject:pin];
    }
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotations:pins];
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [_mapView removeAnnotations:_mapView.annotations];
    _mapView.frame = self.view.bounds;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark Map view delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if([annotation class] == MKUserLocation.class) {
		return nil;
	}
    
    REVClusterPin *pin = (REVClusterPin *)annotation;
    
    MKAnnotationView *annView;
    
    if( [pin nodeCount] > 0 ){
        pin.title = @"___";
        
        annView = (REVClusterAnnotationView*)
        [mapView dequeueReusableAnnotationViewWithIdentifier:@"cluster"];
        
        if( !annView )
            annView = (REVClusterAnnotationView*)
            [[REVClusterAnnotationView alloc] initWithAnnotation:annotation
                                                 reuseIdentifier:@"cluster"];
        
        annView.image = [UIImage imageNamed:@"cluster1.png"];
        annView.canShowCallout = YES;
        
        [(REVClusterAnnotationView*)annView setClusterText:
         [NSString stringWithFormat:@"%i",[pin nodeCount]]];
        
        annView.canShowCallout = NO;
    } else {
        annView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
        
        if( !annView )
            annView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                   reuseIdentifier:@"pin"];
        
        annView.image = [UIImage imageNamed:@"pinpoint1.png"];
        annView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        annView.canShowCallout = YES;
        
        annView.calloutOffset = CGPointMake(-6.0, 0.0);
    }
    return annView;
    
    
}



- (IBAction)segmentedControl:(UISegmentedControl*)sender {
    if (sender.selectedSegmentIndex == 0) {
        _mapView.mapType = MKMapTypeStandard;
    } else if (sender.selectedSegmentIndex == 1) {
        _mapView.mapType = MKMapTypeSatellite;
    } else if (sender.selectedSegmentIndex == 2) {
        _mapView.mapType = MKMapTypeHybrid;
    }
}

- (IBAction)CloseModals:(id)sender
{
    UIViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    [self.navigationController pushViewController: myController animated:YES];
}



- (IBAction)MenuButton:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];

    [self.frostedViewController presentMenuViewController];
}

- (void)mapView:(MKMapView *)mapView
didSelectAnnotationView:(MKAnnotationView *)view
{
    
    if (![view isKindOfClass:[REVClusterAnnotationView class]])
        return;
    
    CLLocationCoordinate2D centerCoordinate = [(REVClusterPin *)view.annotation coordinate];
    
    MKCoordinateSpan newSpan =
    MKCoordinateSpanMake(mapView.region.span.latitudeDelta/2.0,
                         mapView.region.span.longitudeDelta/2.0);
    
    
    [mapView setRegion:MKCoordinateRegionMake(centerCoordinate, newSpan)
              animated:YES];
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    REVClusterAnnotationView *annotationTapped = (REVClusterAnnotationView *)view.annotation;
    for (int i = 0; i<[AnnTitles count]; i++) {
        if ([[AnnTitles objectAtIndex:i] isEqualToString:annotationTapped.title]) {
            [Singleton sharedMySingleton].SelectedShopId = [IDS objectAtIndex:i];
            [Singleton sharedMySingleton].TitleForShopInCatalog = [OriginalTitles objectAtIndex:i];
            UIStoryboard *storyboard = self.storyboard;
            MapViewController *finished = [storyboard instantiateViewControllerWithIdentifier:@"CategoriesViewController"];
            [self presentViewController:finished animated:YES completion:NULL];
            [Singleton sharedMySingleton].AfterMap = YES;
        }
    }
}

@end
