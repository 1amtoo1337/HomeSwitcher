//
//  OutletViewController.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 09.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddOutletViewController.h"
#import "LightSwitchCell.h"
#import "Room.h"
#import "Settings.h"

@interface OutletListViewController : UITableViewController<NSFetchedResultsControllerDelegate, AddOutletDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) Room *room;
@property (strong, nonatomic) Settings *settings;

- (IBAction)addOutletToRoom:(UIBarButtonItem *)sender;

@end
