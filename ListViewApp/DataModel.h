//
//  DataModel.h
//  ListViewApp
//
//  Created by Reetesh on 14/03/18.
//  Copyright © 2018 Reetesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
{
    NSString *titleToNavigationBar;
    NSString *titleToRow;
    NSString *descriptionToRow;
    NSString *imageHrefToRow;
}
@property (strong, nonatomic) NSString *titleToNavigationBar;
@property (strong, nonatomic) NSString *titleToRow;
@property (strong, nonatomic) NSString *descriptionToRow;
@property (strong, nonatomic) NSString *imageHrefToRow;

@end
