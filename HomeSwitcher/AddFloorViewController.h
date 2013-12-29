//
//  AddFloorViewController.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 29.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddFloorViewController;

@protocol AddFloorDelegate <NSObject>

-(void)didFinishFloorInput:(AddFloorViewController *)controller;

@end

@interface AddFloorViewController : UITableViewController<NSFetchedResultsControllerDelegate, UITextFieldDelegate>


@property (nonatomic, weak) id<AddFloorDelegate>delegate;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)validateInput:(UIBarButtonItem *)sender;
- (IBAction)dismissAddView:(UIBarButtonItem *)sender;
@end
