//
//  JSONParseTest.m
//  ListViewAppTests
//
//  Created by Reetesh on 15/03/18.
//  Copyright © 2018 Reetesh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JSONParseController.h"

@interface JSONParseTest : XCTestCase <JSONParserDelegate>

@property XCTestExpectation *expectation;
@property (nonatomic) JSONParseController *jsonController;

@end

@implementation JSONParseTest

- (void)testWebServiceData {
    _expectation = [self expectationWithDescription:@"myTest"];
    self.jsonController = [[JSONParseController alloc] initWithURL:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
    self.jsonController.delegate = self;
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)fetchDataWithModelArray:(NSMutableArray *)model titleString:(NSString *)navigationTitle
{
    //test case for Title at index 0
    NSString *resultStringForTitleAtIndex0 = [[model objectAtIndex:0]titleToRow];
    NSString *expectedStringForTitleAtIndex0 = @"Beavers";
    XCTAssertEqualObjects(resultStringForTitleAtIndex0, expectedStringForTitleAtIndex0);
    XCTAssertNotNil(expectedStringForTitleAtIndex0,@"Expected Title can't be nil");
    
    //test case for Description at index 1
    if([[model objectAtIndex:1]descriptionToRow] == (id)[NSNull null]){
        [[model objectAtIndex:1]setDescriptionToRow:nil];
    }
    NSString *resultStringForDescriptionAtIndex1 = [[model objectAtIndex:1]descriptionToRow];
    XCTAssertNil(resultStringForDescriptionAtIndex1,@"Expected Description to be nil");
    XCTAssertEqualObjects(resultStringForDescriptionAtIndex1, nil);
    
    //test case for ImageHref at index 5
    NSString *resultStringForImageHrefAtIndex5 = [[model objectAtIndex:5]imageHrefToRow];
    NSString *expectedStringForImageHrefAtIndex5 = @"http://icons.iconarchive.com/icons/iconshock/alaska/256/Igloo-icon.png";
    XCTAssertEqualObjects(resultStringForImageHrefAtIndex5, expectedStringForImageHrefAtIndex5);
    
    //test case for ImageHref at index 4
    if([[model objectAtIndex:4]imageHrefToRow] == (id)[NSNull null]){
        [[model objectAtIndex:4]setImageHrefToRow:nil];
    }
    NSString *resultStringForImageHrefAtIndex4 = [[model objectAtIndex:4]imageHrefToRow];
    XCTAssertEqualObjects(resultStringForImageHrefAtIndex4, nil);
    
    //test case for Title at index 1
    NSString *resultStringForTitleAtIndex1 = [[model objectAtIndex:1]titleToRow];
    NSString *expectedStringForTitleAtIndex1 = @"Flag";
    XCTAssertEqualObjects(resultStringForTitleAtIndex1, expectedStringForTitleAtIndex1);
    XCTAssertNotNil(expectedStringForTitleAtIndex0,@"Expected Title can't be nil");
    
    [_expectation fulfill];
}

@end
