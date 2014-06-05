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

@interface MapViewController : UIViewController <MKMapViewDelegate >{
    NSMutableData *receivedData;
    REVClusterMapView *_mapView;
    int height;
    int width;
}

@property (strong, nonatomic) IBOutlet UIView *view2;

- (IBAction)segmentedControl:(UISegmentedControl*)sender;
- (IBAction)CloseModals:(id)sender;

@end
