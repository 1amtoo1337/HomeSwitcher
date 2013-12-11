//
//  SettingsViewController.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 11.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@interface SettingsViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITextField *serverIpTextField;
@property (weak, nonatomic) IBOutlet UITextField *serverPortTextField;
@property (weak, nonatomic) IBOutlet UITextField *webserverIpTextField;
@property (weak, nonatomic) IBOutlet UITextField *webserverPortTextField;
@property (weak, nonatomic) IBOutlet UITextField *webserverPathTextField;

@property (strong,nonatomic) Settings *settings;

- (IBAction)dismissSettings:(UIBarButtonItem *)sender;

@end
