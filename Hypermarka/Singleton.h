//
//  Singleton.h
//  test4
//
//  Created by Bogdan Redkin on 12.03.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject{
}

@property (nonatomic, retain)NSMutableArray *TitlesForAllPodsection;
@property (nonatomic, retain)NSMutableArray *TitlesForPodsectionInStroySection;
@property (nonatomic, retain)NSMutableArray *AllPodPodsection;
@property (nonatomic, retain)NSMutableArray *PodPodSectionForStroySection;
@property (nonatomic, retain)NSMutableArray *NamesForRequestInMap;
@property (nonatomic, retain)NSMutableArray *SelectedIndexesForTableViewController;
@property (nonatomic, retain)NSString *NamesForRequestInCatalog;
@property (nonatomic, retain)NSString *TitleForNavigationBar;
@property (nonatomic, retain)NSString *SelectedShopId;
@property (nonatomic, retain)NSString *TitleForShopInCatalog;
@property (nonatomic, retain)NSArray *DataForInfoView;
@property (nonatomic) BOOL AfterMap;
@property (nonatomic, retain)NSString *TitleForInfoView;
@property (nonatomic, retain)NSString *imageURL;
@property (nonatomic, retain)NSString *priceForElementsOfCatalog;
@property (nonatomic, retain)NSOperationQueue *AllOpetarions;


+(Singleton*) sharedMySingleton;

@end
