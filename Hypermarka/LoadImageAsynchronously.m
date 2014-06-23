//
//  LoadImageAsynchronously.m
//  LoadImageAsynchronousSample
//
//  Created by ArunHS on 2/4/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//
/*--
 
 THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED,INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
 OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 AN ACTION OF CONTRACT,TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 THE USE OF THIS CODE OR ANY OTHER DEALINGS RELATING TO THIS SOFTWARE.
 
 --*/

#import "LoadImageAsynchronously.h"

@implementation LoadImageAsynchronously

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - LoadImageAsyncFromURL Method
- (void)loadImageAsyncFromURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImg{
    if(placeholderImg)
    {
        self.image=placeholderImg;
    }
    
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:90.0];
    if(connection)
    {
        [connection cancel];
        connection=nil;
        data=nil;
    }
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];

}

#pragma mark - NSURLConnection Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[data setLength:0];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData 
{
    if (data == nil)
        data = [[NSMutableData alloc] init];
    [data appendData:incrementalData];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    UIImage *image=[UIImage imageWithData:data];
    if(image)
        self.image=image;
    data=nil;//so as to flush any cache data
    connection=nil;//so as to flush any cache data
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Connection failed: %@", [error description]);
}
    
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
