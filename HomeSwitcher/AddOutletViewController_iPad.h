//
//  AddOutletViewController_iPad.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 30.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddOutletViewController_iPad;

@protocol AddOutletIpadDelegate <NSObject>

-(void)didSelectWith:(AddOutletViewController_iPad *)controller outlets:(NSArray *)theOutlets;
@end

@interface AddOutletViewController_iPad : UITableViewController<UITextFieldDelegate>

@property (nonatomic, weak) id<AddOutletIpadDelegate>delegate;
@property (nonatomic, strong) NSArray *importOutlet;


@end
