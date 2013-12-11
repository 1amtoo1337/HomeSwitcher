//
//  ListViewController.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 09.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRoomViewController.h"

@interface ListViewController : UITableViewController<NSFetchedResultsControllerDelegate,AddRoomDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)reloadData:(id)sender;



@end
