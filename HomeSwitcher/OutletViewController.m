//
//  OutletViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 09.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "OutletViewController.h"
#import "LightSwitchCell.h"
#include "Outlet.h"

@interface OutletViewController ()

@property (strong, nonatomic) NSArray *outlets;

@end

@implementation OutletViewController

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

    //navigationItem Image
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 98, 34)];
    navigationImage.image=[UIImage imageNamed:@"navTitle.png"];
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 98, 34)];
    [workaroundImageView addSubview:navigationImage];
    self.navigationItem.titleView = workaroundImageView;
    
    //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //nsset -> array
    self.outlets = [self.room.outlets allObjects];
    
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.room.name;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.outlets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    LightSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
    // Configure the cell...
    Outlet *outlet = [self.outlets objectAtIndex:indexPath.row];
    cell.outletName.text = outlet.name;
    cell.outletName.font = [UIFont fontWithName:@"Avenir" size:16];

    
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;

}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



- (IBAction)addOutletToRoom:(UIBarButtonItem *)sender {
}

-(void)didSelectWith:(AddOutletViewController *)controller outlet:(NSArray *)outlet
{
 
    NSManagedObjectContext *context = [self managedObjectContext];

    Outlet *tOutlet =[NSEntityDescription
                      insertNewObjectForEntityForName:@"Outlet"
                      inManagedObjectContext:context];
    tOutlet.name = [outlet objectAtIndex:0];
    tOutlet.state = 0;
    tOutlet.room = self.room;
    
    Command *tCommand = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Command"
                         inManagedObjectContext:context];
    tCommand.on = [outlet objectAtIndex:1];
    tCommand.off = [outlet objectAtIndex:2];
    tCommand.outlet = tOutlet;
    tOutlet.command = tCommand;
    
    [self.room addOutletsObject:tOutlet];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    //reload the current room from core data into the self.room
    
    [self.tableView reloadData];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"outletViewToOutletAddSegue"])
    {
        AddOutletViewController *vc = [segue destinationViewController];
        vc.delegate = self;
    }
}


@end
