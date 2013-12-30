//
//  RoomListViewController_iPad.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 29.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddFloorAndRoomViewController_iPad.h"

@interface RoomListViewController_iPad : UITableViewController<NSFetchedResultsControllerDelegate, AddFloorIpadDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
- (IBAction)addFloorAndRoomButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)displaySettingsButtonPressed:(UIBarButtonItem *)sender;

@end
