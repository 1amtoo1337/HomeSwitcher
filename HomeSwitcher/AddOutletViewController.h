//
//  AddOutletViewController.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 10.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddOutletViewController : UITableViewController <UITextFieldDelegate>

- (IBAction)cancelOutletEntry:(UIBarButtonItem *)sender;

- (IBAction)saveOutlet:(UIBarButtonItem *)sender;
@end
