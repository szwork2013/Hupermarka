//
//  MapViewController.h
//  test4
//
//  Created by Bogdan Redkin on 11.03.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "REVClusterMapView.h"
#import "TableViewController.h"

@interface MapViewController : UIViewController <MKMapViewDelegate >{
    NSMutableData *receivedData;
    REVClusterMapView *_mapView;
    BOOL first;
    int height;
    int width;
}

@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) NSMutableArray *AnnTitles;
@property (strong, nonatomic) NSMutableArray *OriginalTitles;
@property (strong, nonatomic) NSMutableArray *IDS;

- (IBAction)segmentedControl:(UISegmentedControl*)sender;
- (IBAction)CloseModals:(id)sender;
- (IBAction)BackButton:(id)sender;

@end
