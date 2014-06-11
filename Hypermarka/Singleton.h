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
@property (nonatomic, retain)NSMutableArray *Titles;
@property (nonatomic, retain)NSString *path;
@property (nonatomic, retain)NSMutableArray *podsections;
@property (nonatomic, retain)NSMutableArray *names;
@property (nonatomic, retain)NSMutableArray *SelectedIndexes;
@property (nonatomic)int width;
@property (nonatomic)int height;
@property (nonatomic)BOOL close;
@property (nonatomic)UIDeviceOrientation orientation;
@property (nonatomic, retain)NSString *TextLabelCell;
@property (nonatomic, retain)NSMutableArray *Titles2;
@property (nonatomic, retain)NSMutableArray *podsections2;
@property (nonatomic, retain)NSMutableArray *names2;
@property (nonatomic, retain)NSString *SelectedName;
@property (nonatomic, retain)NSString *SelectedTitle;
@property (nonatomic, retain)NSString *ShopId;
@property (nonatomic, retain)NSString *InfoTitle;
@property (nonatomic, retain)NSArray *info2;
@property (nonatomic) BOOL AfterMap;
@property (nonatomic, retain)NSString *TitleForInfo;
@property (nonatomic) BOOL InfoClosed;
@property (nonatomic) BOOL FilterOpen;

-(void)test;

+(Singleton*) sharedMySingleton;

@end
