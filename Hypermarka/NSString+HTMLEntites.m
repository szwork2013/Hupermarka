//
//  NSString+HTMLEntites.m
//  IzhComBankViewer
//
//  Created by Aleksandr Medvedev on 29.07.13.
//  Copyright (c) 2013 mifors. All rights reserved.
//

#import "NSString+HTMLEntites.h"

@implementation NSString (HTMLEntites)

- (NSString *)stringByDecodingXMLEntities {
    NSUInteger myLength = [self length];

    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25)];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];    
    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];
    do {
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        if ([scanner isAtEnd]) {
            goto finish;
        }
        if ([scanner scanString:@"&amp;" intoString:NULL])
            [result appendString:@"&"];
        else if ([scanner scanString:@"&apos;" intoString:NULL])
            [result appendString:@"'"];
        else if ([scanner scanString:@"&quot;" intoString:NULL])
            [result appendString:@"\""];
        else if ([scanner scanString:@"&#60;" intoString:NULL])
            [result appendString:@"<"];
        else if ([scanner scanString:@"&#62;" intoString:NULL])
            [result appendString:@">"];
        
        else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            }
            else {
                gotNumber = [scanner scanInt:(int*)&charCode];
            }
            
            if (gotNumber) {
                [result appendFormat:@"%C", (unichar)charCode];
                
                [scanner scanString:@";" intoString:NULL];
            }
            else {
                NSString *unknownEntity = @"";                
                [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                [result appendFormat:@"&#%@%@", xForHex, unknownEntity];
                NSLog(@"Expected numeric character entity but got &#%@%@;", xForHex, unknownEntity);                
            }            
        }
        else {
            NSString *amp;            
            [scanner scanString:@"&" intoString:&amp];
            [result appendString:amp];
        }        
    }
    while (![scanner isAtEnd]);
finish:
    {
        NSString* result_=[result stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        result_=[result_ stringByReplacingOccurrencesOfString:@"&#34;" withString:@"\""];
        result_=[result_ stringByReplacingOccurrencesOfString:@"&laquo;" withString:@"«"];
        result_=[result_ stringByReplacingOccurrencesOfString:@"&raquo;" withString:@"»"];
        result_=[result_ stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        result_=[result_ stringByReplacingOccurrencesOfString:@"&ndash;" withString:@"-"];
        result_=[result_ stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        
        BOOL existWhiteSpace;
        do{
            existWhiteSpace=NO;
            if([result_ rangeOfString:@"  "].location!=NSNotFound){
                existWhiteSpace=YES;
                result_=[result_ stringByReplacingOccurrencesOfString:@"  " withString:@""];
            }
        }while (existWhiteSpace);
        return result_;
    }
}

- (NSString *)stringByRemoveTags
{
    NSArray* contentToRemoved=@[@{ @"open":@"<style>",  @"close":@"</style>"},
                                @{ @"open":@"<xml>",    @"close":@"</xml>"},
                                @{ @"open":@"<",        @"close":@">" } ];
    
    NSMutableString* result=[NSMutableString stringWithString:self];
    BOOL existTags;
    for(int i=0;i<contentToRemoved.count;i++)do {
        existTags=NO;
        NSDictionary* currentSymbol=[contentToRemoved objectAtIndex:i];
        NSRange tagOpenBracketPosition=[result rangeOfString:[currentSymbol objectForKey:@"open"]];
        if(tagOpenBracketPosition.location!=NSNotFound){
            existTags=YES;
            NSRange tagCloseBracketPosition=[result rangeOfString:[currentSymbol objectForKey:@"close"]];
            [result deleteCharactersInRange:NSMakeRange(tagOpenBracketPosition.location, tagCloseBracketPosition.location-tagOpenBracketPosition.location+[[currentSymbol objectForKey:@"close"] length])];
        }
    } while (existTags);
    NSArray* lines=[result componentsSeparatedByString:@"\n"];
    [result setString:@""];
    for(int i=0;i<lines.count;i++)if([[lines objectAtIndex:i] length]>2){
        [result setString:[result stringByReplacingOccurrencesOfString:@"\r" withString:@""]];
        [result appendString:[lines objectAtIndex:i]];
        [result appendString:@"\n"];
    }
    return result;
}



@end
