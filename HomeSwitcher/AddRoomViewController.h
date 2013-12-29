//
//  AddRoomViewController.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 09.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddOutletViewController.h"
#import "Floor.h"

@class AddRoomViewController;

@protocol AddRoomDelegate <NSObject>

-(void)didFinishRoomInput:(AddRoomViewController *)controller;

@end


@interface AddRoomViewController : UITableViewController<NSFetchedResultsControllerDelegate, UITextFieldDelegate, AddOutletDelegate>

@property (nonatomic, weak) id<AddRoomDelegate>delegate;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) Floor *floor;

- (IBAction)validateInput:(UIBarButtonItem *)sender;
- (IBAction)dismissAddView:(UIBarButtonItem *)sender;
@end
