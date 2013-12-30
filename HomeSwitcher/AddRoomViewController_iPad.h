//
//  AddRoomViewController_iPad.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 30.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddOutletViewController_iPad.h"
#import "ProgressHUD.h"
#import "Floor.h"
#import "Room.h"
#import "Outlet.h"
#import "Command.h"

@class AddRoomViewController_iPad;

@protocol AddRoomIpadDelegate <NSObject>

-(void)didFinishRoomInput:(AddRoomViewController_iPad *)controller;

@end

@interface AddRoomViewController_iPad : UITableViewController<NSFetchedResultsControllerDelegate,UITextFieldDelegate, AddOutletIpadDelegate>

@property (nonatomic, weak) id<AddRoomIpadDelegate>delegate;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) Floor *floor;

@end
