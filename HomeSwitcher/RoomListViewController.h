//
//  ListViewController.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 09.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Floor.h"
#import "AddRoomViewController.h"

@interface RoomListViewController : UITableViewController<NSFetchedResultsControllerDelegate,AddRoomDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) Floor *floor;

- (IBAction)reloadData:(id)sender;

- (IBAction)addBarButtonPressed:(id)sender;


@end
