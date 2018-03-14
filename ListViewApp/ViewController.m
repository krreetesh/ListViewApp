//
//  ViewController.m
//  ListViewApp
//
//  Created by Reetesh on 3/11/18.
//  Copyright © 2018 Reetesh. All rights reserved.
//

#import "ViewController.h"
#import "JSONParseController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, JSONParserDelegate> //conforming to protocol

@end

@implementation ViewController

@synthesize rowArray, table;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor cyanColor]];
    
    self.rowArray = [[NSMutableArray alloc]init];
    
    NSString *urlString = @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json";
    
    JSONParseController *jsonParserObj = [[JSONParseController alloc]initWithURL:urlString];
    
    jsonParserObj.delegate = self;

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

#pragma mark - implement protocol method
//Implementing the Protocol method - fetchDataWithModelArray
- (void)fetchDataWithModelArray:(NSMutableArray*)model titleString:(NSString *)navigationTitle
{
    //update title of navigation bar
    self.navigationController.navigationBar.topItem.title = navigationTitle;
    //update model data
    rowArray = model;
    //reload table view
    [self.table reloadData];
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
    
    //cell.imageView.frame = CGRectMake(cell.imageView.frame.origin.x, cell.imageView.frame.origin.y, 40,40);
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // display title in cell
    if([[self.rowArray objectAtIndex:indexPath.row]titleToRow]==nil || [[[self.rowArray objectAtIndex:indexPath.row]descriptionToRow] isEqual:[NSNull null]]){
        cell.textLabel.text = @"";
    }
    else{
        cell.textLabel.text = [[self.rowArray objectAtIndex:indexPath.row]titleToRow];
    }
    
    //display description in cell
    if([[self.rowArray objectAtIndex:indexPath.row]descriptionToRow]==nil || [[[self.rowArray objectAtIndex:indexPath.row]descriptionToRow] isEqual:[NSNull null]]){
        cell.detailTextLabel.text = @"";
    }
    else{
        cell.detailTextLabel.text = [[self.rowArray objectAtIndex:indexPath.row]descriptionToRow];
        cell.detailTextLabel.numberOfLines = 0;
    }
    
    //display image in imageview of cell
    NSURL *imgUrl;
    if([[self.rowArray objectAtIndex:indexPath.row]imageHrefToRow]==(id) [NSNull null] || [[[self.rowArray objectAtIndex:indexPath.row]imageHrefToRow] length]==0 || [[[self.rowArray objectAtIndex:indexPath.row]imageHrefToRow] isEqualToString:@""]){
        imgUrl = nil;
    }
    else{
        imgUrl = [NSURL URLWithString:[[self.rowArray objectAtIndex:indexPath.row]imageHrefToRow]];
    }
    
    if (!isDragging_msg && !isDecliring_msg)
    {
        // download the image asynchronously
        if(imgUrl!=nil){
        [self downloadImageWithURL:imgUrl completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                cell.imageView.frame = CGRectMake(cell.imageView.frame.origin.x, cell.imageView.frame.origin.y, 40,40);
                cell.imageView.image = image;
            }
        }];
        }
    }
    //    else {
    //        cell.imageView.frame = CGRectMake(cell.imageView.frame.origin.x, cell.imageView.frame.origin.y, 40,40);
    //        cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
    //    }
    
    return cell;
}

#pragma mark - method to download image asynchronously
// method to download image from url asynchronously
- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

#pragma mark - Handling image loading on scroll
// handling image loading on scroll
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    isDragging_msg = FALSE;
    //[self.table reloadData];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    isDecliring_msg = FALSE;
    //[self.table reloadData];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isDragging_msg = TRUE;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    isDecliring_msg = TRUE;
}

#pragma mark - Interface Orientation
// Handling orientation change form portrait to landscape and vice versa
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // do something before rotation
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    self.table.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    
    [table reloadData];
}


@end
