//
//  JSONParseController.m
//  ListViewApp
//
//  Created by Reetesh on 14/03/18.
//  Copyright © 2018 Reetesh. All rights reserved.
//

#import "JSONParseController.h"

@implementation JSONParseController

//method for initializing NSURLRequest & NSURLConnection
-(id)initWithURL:(NSString*)jsonURLStr{
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:jsonURLStr]];
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSLog(@"%@", conn);
    return self;
}

#pragma mark - servcie call using NSURLConnection
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    [self parseTheJSONData];
    
    [self setDataModelClassAndDelegate];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

#pragma mark - method to parse JSON Data
//parse JSON Data
-(void)parseTheJSONData
{
    //Do your parsing here and fill it into data_array
    NSError *error;
    NSString *string = [[NSString alloc] initWithData:_responseData encoding:NSASCIIStringEncoding];
    NSData *dataUTF8 = [string dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:dataUTF8 options:kNilOptions error:&error];
    
    if (error) {
        //Error handling
        NSLog(@"%@",error);
    } else {
        //use your json object
        [self setTitleStr:[jsonObject objectForKey:@"title"]];
        [self setDataArray:[jsonObject objectForKey:@"rows"]];
    }
}

#pragma mark - method to use protocol delegate
// setting data model into array and using protocol delegate method
- (void)setDataModelClassAndDelegate
{
    DataModel *ob;
    
    NSMutableArray *ar = [[NSMutableArray alloc]init];
    
    for (NSString *obj in self.dataArray)
    {
        ob = [[DataModel alloc]init];
        
        [ob setTitleToRow:[obj valueForKey:@"title"]];
        [ob setDescriptionToRow:[obj valueForKey:@"description"]];
        [ob setImageHrefToRow:[obj valueForKey:@"imageHref"]];
        
        [ar addObject:ob];
    }
    // Using the Protocol delegate method - fetchDataWithModelArray
    if ([self.delegate respondsToSelector:@selector(fetchDataWithModelArray:titleString:)]) {
        [self.delegate fetchDataWithModelArray:ar titleString:_titleStr];
    }
}


@end
