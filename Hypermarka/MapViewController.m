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
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    UIDeviceOrientation orientation1 = [[UIDevice currentDevice] orientation];
    [Singleton sharedMySingleton].orientation = orientation1;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    
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
    }

    
    if ([Singleton sharedMySingleton].width == 0) {
        [Singleton sharedMySingleton].width = screenBounds.size.width;
        [Singleton sharedMySingleton].height = screenBounds.size.height;
    }
    
    
    CGRect viewBounds = CGRectMake(0, 0, [Singleton sharedMySingleton].width, [Singleton sharedMySingleton].height);
    
    
    _mapView = [[REVClusterMapView alloc] initWithFrame:viewBounds];
    _mapView.delegate = self;
    
    [self.view2 addSubview:_mapView];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [_mapView setRegion:MKCoordinateRegionMake(IzhveskCoordinate, citySpan) animated:YES];
    NSMutableString *namez = [NSMutableString string];
    for (int i=0; i<[[Singleton sharedMySingleton].names count]; i++) {
        NSString *name = [NSString stringWithFormat:@"%@;",[[Singleton sharedMySingleton].names objectAtIndex:i]];
        [name substringToIndex:[name length]-1];
        [namez appendString:name];
    }
    if ([[Singleton sharedMySingleton].names count]==0) {
        [namez appendString:@"proektarhitektura;zemelnieraboti;perekritiya;krovlyavodostok;fasad;ozelenenylandshaft;prochee;dizain;lakikraskiklei;napolnyepokritiya;stenovyepokritiya;potolki;oknadveri;elektrika;santehnika;lodjiibalkoni;prochee;lakikraskiklei;kirpichbetonjbi;sypuchyematerialy;pilomaterialy;metalloprodukciya;plastikovyetruby;uteplenyeizolyaciya;peregorodkigipsokarton;metizykrepej;prochee;garaji;bani;teplicy;besedki;kaminymangaly;baseyny;zabopyvorota;prochee;septikikanalizaciya;gaz;elektrichestvo;vodateplo;ventilyaciyakondicionirovanie;svyaztvinternet;ohrana;umnyidom;electroinstrument;pnevmoinstrument;benzoinstrument;slesarnomontajnyinstrument;izmeritelnayatehnika;sadovayatehnikainstrument;svarka;organizacii;specialisty;brigady;rabochie;masternavseruki;prochee;ofch"];
    }
    // создаем запрос
    NSString *url = [NSString stringWithFormat:@"http://work.hypermarka.com/hm/svc-shoplist?list=%@&swlat=56.4922648749152&swlng=52.202664648437505&nelat=57.24433849873821&nelng=54.2351353515625", namez];
    NSLog(@"%@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    
    // создаём соединение и начинаем загрузку
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (connection) {
        // соединение началось
        NSLog(@"Connecting...");
        // создаем NSMutableData, чтобы сохранить полученные данные
        receivedData = [NSMutableData data];
    } else {
        // при попытке соединиться произошла ошибка
        NSLog(@"Connection error!");
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [_mapView removeAnnotations:_mapView.annotations];
    _mapView.frame = self.view.bounds;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}
- (void)didRotate:(NSNotification *)notification{
    
    UIDeviceOrientation orientation1 = [[UIDevice currentDevice] orientation];
    [Singleton sharedMySingleton].orientation = orientation1;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    
    if (orientation1 == UIDeviceOrientationLandscapeLeft) {
        NSLog(@"Кнопка Home сп  рава (Альбомная ориентация) высоту и ширину надо поменять");
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
    }
}

#pragma mark -
#pragma mark Map view delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if([annotation class] == MKUserLocation.class) {
		//userLocation = annotation;
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
        
        [(REVClusterAnnotationView*)annView setClusterText:
         [NSString stringWithFormat:@"%i",[pin nodeCount]]];
        
        annView.canShowCallout = NO;
    } else {
        annView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
        
        if( !annView )
            annView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                   reuseIdentifier:@"pin"];
        
        annView.image = [UIImage imageNamed:@"pinpoint1.png"];
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
    if (![Singleton sharedMySingleton].names) {
        UIStoryboard *storyboard = self.storyboard;
        MapViewController *finished = [storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
        
        [self presentViewController:finished animated:YES completion:NULL];
    }
    else{
        [self dismissModalViewControllerAnimated:YES];
        [Singleton sharedMySingleton].close = YES;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // получен ответ от сервера
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // добавляем новые данные к receivedData
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error {
    
    // выводим сообщение об ошибке
    NSString *errorString = [[NSString alloc] initWithFormat:@"Connection failed! Error - %@ %@ %@",
                             [error localizedDescription],
                             [error description],
                             [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]];
    NSLog(@"%@",errorString);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // данные получены
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:nil];
    NSLog(@"%@", json);
    NSArray *metka = [json objectForKey:@"metka"];
    NSLog(@"metka: %@", metka);
    NSArray *addresses = [metka valueForKey:@"address"];
    NSArray *lat = [metka valueForKey:@"lat"];
    NSArray *lon = [metka valueForKey:@"lon"];
    NSArray *names = [metka valueForKey:@"name"];
    NSArray *worktime = [metka valueForKey:@"worktime"];
    long Ncount = [names count];
    NSMutableArray *pins = [NSMutableArray array];

    
    for (int i = 0; i<Ncount; i++) {
        NSString *titles =[NSString stringWithFormat:@"%@ (%@)", [addresses objectAtIndex:i], [names objectAtIndex:i]];
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
    
    [_mapView addAnnotations:pins];
    
}

- (void)mapView:(MKMapView *)mapView
didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"REVMapViewController mapView didSelectAnnotationView:");
    
    if (![view isKindOfClass:[REVClusterAnnotationView class]])
        return;
    
    CLLocationCoordinate2D centerCoordinate = [(REVClusterPin *)view.annotation coordinate];
    
    MKCoordinateSpan newSpan =
    MKCoordinateSpanMake(mapView.region.span.latitudeDelta/2.0,
                         mapView.region.span.longitudeDelta/2.0);
    
    //mapView.region = MKCoordinateRegionMake(centerCoordinate, newSpan);
    
    [mapView setRegion:MKCoordinateRegionMake(centerCoordinate, newSpan)
              animated:YES];
}

-(void)viewDidUnload{
    NSLog(@"bad1");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Map Memory warning");
}

@end
