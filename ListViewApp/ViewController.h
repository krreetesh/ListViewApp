//
//  ViewController.h
//  ListViewApp
//
//  Created by Reetesh on 3/11/18.
//  Copyright © 2018 Reetesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSMutableArray *rowArray;
    UITableView *table;
    BOOL isDragging_msg, isDecliring_msg;
}

@property (strong,nonatomic) NSMutableArray *rowArray;
@property (strong,nonatomic) UITableView *table;

-(void)refreshView:(UIRefreshControl *)refresh;

@end

