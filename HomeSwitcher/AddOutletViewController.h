//
//  AddOutletViewController.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 10.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Outlet.h"
#import "Command.h"

@class AddOutletViewController;

@protocol AddOutletDelegate <NSObject>

-(void)didSelectWith:(AddOutletViewController *)controller outlet:(NSArray *)outlet;
@end

@interface AddOutletViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) id<AddOutletDelegate>delegate;
//44,320
@property (nonatomic, retain) UIButton *btnDone;
@property (nonatomic, retain) UIButton *btnNext;
@property (nonatomic, retain) UIButton *btnPrev;
@property (nonatomic, retain) UIView *inputAccView;
@property (nonatomic, retain) UITextField *txtActiveField;
@property (nonatomic, strong) UIView *keyboardToolbar;
@property (nonatomic, strong) NSArray *importOutlet;

- (IBAction)cancelOutletEntry:(UIBarButtonItem *)sender;
- (IBAction)validateInput:(UIBarButtonItem *)sender;

@end
