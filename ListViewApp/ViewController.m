//
//  ViewController.m
//  ListViewApp
//
//  Created by Reetesh on 3/11/18.
//  Copyright © 2018 Reetesh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLConnectionDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

@synthesize rowArray, table;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor cyanColor]];
    
    self.rowArray = [[NSMutableArray alloc]init];
    
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"]];
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSLog(@"%@", conn);
    
    //create table view and set with delegate and data source
    self.table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSError *error;
    NSString *string = [[NSString alloc] initWithData:_responseData encoding:NSASCIIStringEncoding];
    NSData *dataUTF8 = [string dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:dataUTF8 options:kNilOptions error:&error];
    
    if (error) {
        //Error handling
    } else {
        //use your json object
        self.rowArray = [jsonObject objectForKey:@"rows"];
        titleString = [jsonObject objectForKey:@"title"];
        NSLog(@"rowArray=%@",self.rowArray);
    }
    //update title of navigation bar
    self.navigationController.navigationBar.topItem.title = titleString;
    //reload tableview
    [self.table reloadData];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    
    // display title in cell
    if([[self.rowArray objectAtIndex:indexPath.row]valueForKey:@"title"]!=[NSNull null]){
        cell.textLabel.text =  [[self.rowArray objectAtIndex:indexPath.row]valueForKey:@"title"];
    } else{
        cell.textLabel.text = @"";
    }
    //display description in cell
    if([[self.rowArray objectAtIndex:indexPath.row]valueForKey:@"description"]!=[NSNull null]){
        cell.detailTextLabel.text =  [[self.rowArray objectAtIndex:indexPath.row]valueForKey:@"description"];
        cell.detailTextLabel.numberOfLines = 0;
    } else{
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}



@end
