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
#import "REFrostedViewController.h"
#import "MapDownloads.h"

@interface MapViewController : UIViewController <MKMapViewDelegate >{
    NSMutableData *receivedData;
    MapDownloads *md;
    BOOL first;
    IBOutlet REVClusterMapView *_mapView;
    int height;
    int width;
}

@property (strong, nonatomic) NSMutableArray *AnnTitles;
@property (strong, nonatomic) NSMutableArray *OriginalTitles;
@property (strong, nonatomic) NSMutableArray *IDS;

- (IBAction)CloseModals:(id)sender;
- (IBAction)MenuButton:(id)sender;

@end
