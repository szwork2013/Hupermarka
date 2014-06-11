//
//  NSString+HTMLEntites.h
//  IzhComBankViewer
//
//  Created by Aleksandr Medvedev on 29.07.13.
//  Copyright (c) 2013 mifors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HTMLEntites)

- (NSString *)stringByDecodingXMLEntities;
- (NSString *)stringByRemoveTags;

@end
