//
//  SettingsViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 11.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //core data
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
    
    [self loadSettings];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissSettings:(UIBarButtonItem *)sender
{
    [self saveSettings];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveSettings
{
    NSManagedObjectContext *context = self.managedObjectContext;
    
    //only create this entity on the first launch
    //load the current entity when you re enter this controller
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Settings" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    NSArray *settingsArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if(settingsArray.count == 0)
    {
        Settings *tSettings = [NSEntityDescription insertNewObjectForEntityForName:@"Settings" inManagedObjectContext:context];
        
        tSettings.name = @"Settings";
        tSettings.serverIP = self.serverIpTextField.text;
        tSettings.serverPort = self.serverPortTextField.text;
        tSettings.webserverIP = self.webserverIpTextField.text;
        tSettings.webserverPort = self.webserverPortTextField.text;
        tSettings.webserverIndexPath = self.webserverPathTextField.text;
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }else if(settingsArray.count == 1)
    {
        //load the current settings array from objectContext
        //edit the data and save it to core data
        // Retrieve the entity from the local store -- much like a table in a database
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Settings" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        
        // Set the predicate -- much like a WHERE statement in a SQL database
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", @"Settings"];
        [request setPredicate:predicate];
        
        // Set the sorting -- mandatory, even if you're fetching a single record/object
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptors];
        
        Settings *tSettings = [[context executeFetchRequest:request error:&error] objectAtIndex:0];
        NSLog(@"ip: '%@'",tSettings.serverIP);
        tSettings.serverIP = self.serverIpTextField.text;
        tSettings.serverPort = self.serverPortTextField.text;
        tSettings.webserverIP = self.webserverIpTextField.text;
        tSettings.webserverPort = self.webserverPortTextField.text;
        tSettings.webserverIndexPath = self.webserverPathTextField.text;
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }

        
    }
}

-(void)loadSettings
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Settings" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    NSArray *settingsArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if(settingsArray.count != 0)
    {
        NSLog(@"There is a current setting");
        
        self.settings = [settingsArray objectAtIndex:0];
        NSLog(@"ArrayContents: '%@'",settingsArray);
        NSLog(@"ip: '%@' port:'%@'",self.settings.serverIP, self.settings.serverPort);

        self.serverIpTextField.text = self.settings.serverIP;
        self.serverPortTextField.text = self.settings.serverPort;
        self.webserverIpTextField.text = self.settings.webserverIP;
        self.webserverPortTextField.text = self.settings.webserverPort;
        self.webserverPathTextField.text = self.settings.webserverIndexPath;
        
    }else{
        NSLog(@"there is no current setting");
    }
    
    
}


@end
