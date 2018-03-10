//
//  ListViewAppTests.m
//  ListViewAppTests
//
//  Created by Reetesh on 3/11/18.
//  Copyright © 2018 Reetesh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface ListViewAppTests : XCTestCase

@property (nonatomic) ViewController *vc;

@end

@implementation ListViewAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [[ViewController alloc] init];
    self.vc.table = [[UITableView alloc] initWithFrame:self.vc.view.bounds style:UITableViewStylePlain];
    [self.vc.table setDelegate:self.vc];
    [self.vc.table setDataSource:self.vc];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
    self.vc.table = nil;
    [super tearDown];
}

#pragma mark - View loading tests
-(void)testThatViewLoads
{
    XCTAssertNotNil(self.vc.view, @"View not initiated properly");
}

-(void)testThatTableViewLoads
{
    XCTAssertNotNil(self.vc.table, @"TableView not initiated");
}


#pragma mark - UITableView tests
- (void)testThatViewConformsToUITableViewDataSource
{
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testThatTableViewHasDataSource
{
    XCTAssertNotNil(self.vc.table.dataSource, @"Table datasource cannot be nil");
}

- (void)testThatViewConformsToUITableViewDelegate
{
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewIsConnectedToDelegate
{
    XCTAssertNotNil(self.vc.table.delegate, @"Table delegate cannot be nil");
}

@end
