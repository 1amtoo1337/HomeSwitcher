//
//  LightSwitchCell.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 10.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>



/*
 in the outletviewcontroller when a switch is switch, send the command from the outlet of that switch over the network
 */
@interface LightSwitchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *outletSwitch;
@property (weak, nonatomic) IBOutlet UILabel *outletName;
@end
