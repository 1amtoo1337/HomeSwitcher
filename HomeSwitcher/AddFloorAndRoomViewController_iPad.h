//
//  AddFloorAndRoomViewController_iPad.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 29.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRoomViewController_iPad.h"

@interface AddFloorAndRoomViewController_iPad : UITableViewController<NSFetchedResultsControllerDelegate, UITextFieldDelegate, AddRoomIpadDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
