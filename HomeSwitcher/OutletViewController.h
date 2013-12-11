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

@interface OutletViewController : UITableViewController<NSFetchedResultsControllerDelegate, AddOutletDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) Room *room;

- (IBAction)addOutletToRoom:(UIBarButtonItem *)sender;

@end
