//
//  RoomDisplayViewController.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 30.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomDisplayViewController : UIViewController<NSFetchedResultsControllerDelegate ,UITableViewDelegate, UINavigationControllerDelegate, UITableViewDataSource, UIImagePickerControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultController;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *pictureAddButton;

- (IBAction)pictureAddButtonPressed:(UIButton *)sender;
@end
