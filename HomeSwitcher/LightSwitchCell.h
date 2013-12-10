//
//  LightSwitchCell.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 10.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LightSwitchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *outletSwitch;
@property (weak, nonatomic) IBOutlet UILabel *outletName;
@end
