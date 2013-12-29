//
//  AddFloorViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 29.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "AddFloorViewController.h"
#import "Floor.h"

@interface AddFloorViewController ()

@end

@implementation AddFloorViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //core data
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (IBAction)validateInput:(UIBarButtonItem *)sender
{
    [self saveData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


-(NSString *) genRandStringLength: (int) len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

-(void)saveData
{
    NSString *floorName = [self genRandStringLength:5]; //((UITextField*)[self.view viewWithTag:11]).text;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    Floor *floor = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Floor"
                  inManagedObjectContext:context];
    [floor setValue:floorName forKey:@"name"];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    [self.delegate didFinishFloorInput:self]; //kasius knaktus
    
}


- (IBAction)dismissAddView:(UIBarButtonItem *)sender
{
//    NSString *text = ((UITextField*)[self.view viewWithTag:11]).text;
//    
//    if(![text isEqualToString:@""] || self.outlets.count > 0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cancel" message:@"Are you sure you want to cancel?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok" , nil];
//        [alert show];
//        
//    }else if([text isEqualToString:@""])
//    {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
