//
//  TMDCategoryTableViewCell.h
//  TradeMeDisplay
//
//  Created by Charles on 5/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMDCategory.h"

@interface TMDCategoryTableViewCell : UITableViewCell

- (void)fillDataWithCategory:(TMDCategory *)category;

@end
