//
//  JSONParseController.h
//  ListViewApp
//
//  Created by Reetesh on 14/03/18.
//  Copyright © 2018 Reetesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"
#import "ViewController.h"

//Creating the Protocol - JSONParserDelegate
@protocol JSONParserDelegate <NSObject>
- (void)fetchDataWithModelArray:(NSMutableArray*)model titleString:(NSString*)navigationTitle;
@end

@interface JSONParseController : NSObject <NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
}

@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) NSString *titleStr;
//Creating a delegate property
@property(nonatomic, weak)id <JSONParserDelegate> delegate;
//method for initializing NSURLRequest & NSURLConnection
-(id)initWithURL:(NSString*)jsonURLStr;


@end
