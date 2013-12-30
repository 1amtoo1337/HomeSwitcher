//
//  AddFloorAndRoomViewController_iPad.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 29.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRoomViewController_iPad.h"

@class AddFloorAndRoomViewController_iPad;

@protocol  AddFloorIpadDelegate <NSObject>

-(void)didFinishRoomInput;

@end

@interface AddFloorAndRoomViewController_iPad : UITableViewController<NSFetchedResultsControllerDelegate, UITextFieldDelegate, AddRoomIpadDelegate>

@property (strong, nonatomic) id<AddFloorIpadDelegate>delegate;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
