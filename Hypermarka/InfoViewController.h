//
//  InfoViewController.h
//  Hypermarka
//
//  Created by Bogdan Redkin on 06.06.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
@interface InfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *NavigationTitle;
- (IBAction)BackButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
