//
//  OutletViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 09.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "OutletViewController.h"
#import "SevenSwitch.h"
#import "AsyncUdpSocket.h"
#include "Outlet.h"

@interface OutletViewController ()

@property (strong, nonatomic) NSArray *outlets;
@property (strong, nonatomic) AsyncUdpSocket *socket;
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
    
    NSLog(@"Creating UDP socket");
    self.socket = [[AsyncUdpSocket alloc]initWithDelegate:self];
    if (![self.socket bindToPort:21369 error:nil])
        NSLog(@"Bind error");
    [self.socket receiveWithTimeout:-1 tag:1];			//Setup to receive next UDP packet


    [self loadSettings];
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
    [cell.outletSwitch addTarget:self action:@selector(lightSwitchSwitched:) forControlEvents:UIControlEventTouchUpInside];
    cell.outletSwitch.hidden = YES;
    // Configure the cell...
    Outlet *outlet = [self.outlets objectAtIndex:indexPath.row];
    cell.outletName.text = outlet.name;
    cell.outletName.font = [UIFont fontWithName:@"Avenir" size:16];

    SevenSwitch *mySwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(251, 6, 51, 31)];
    [mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    mySwitch.offImage = [UIImage imageNamed:@"blitz_off.png"];
    mySwitch.onImage = [UIImage imageNamed:@"blitz.png"];
    mySwitch.onTintColor = [UIColor colorWithRed:38.0f / 255.0f green:126.0f / 255.0f blue:214.0f / 255.0f alpha:1.00f];

    [cell addSubview:mySwitch];
    
    return cell;
}

- (void)switchChanged:(SevenSwitch *)sender {
    NSLog(@"Changed value to: %@", sender.on ? @"ON" : @"OFF");

    NSIndexPath *indexPath = [self GetIndexPathFromSender:sender];
    
    Outlet *currentOutlet = [self.outlets objectAtIndex:indexPath.row];
    Command *currentCommand = currentOutlet.command;
    NSLog(@"Command on: '%@' Command off: '%@'",currentCommand.on, currentCommand.off);
    
    if(sender.on)
    {
        NSLog(@"sending on command: '%@'",currentCommand.on);
        
        AsyncUdpSocket *socket=[[AsyncUdpSocket alloc]initWithDelegate:self];
        NSLog(@"%i",[self.settings.serverPort integerValue]);
        NSString * address = self.settings.serverIP;
        UInt16 port = [self.settings.serverPort integerValue];
        NSData * data = [currentCommand.on dataUsingEncoding:NSUTF8StringEncoding];
        [socket sendData:data toHost:address port:port withTimeout:-1 tag:1];
        
    }else if(!sender.on)
    {
        NSLog(@"sending off command: '%@'",currentCommand.off);
        
        AsyncUdpSocket *socket=[[AsyncUdpSocket alloc]initWithDelegate:self];
        NSString * address = self.settings.serverIP;
        UInt16 port = [self.settings.serverPort integerValue];
        NSData * data = [currentCommand.off dataUsingEncoding:NSUTF8StringEncoding];
        [socket sendData:data toHost:address port:port withTimeout:-1 tag:1];
        
    }
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

-(void) lightSwitchSwitched:(id)sender
{
    UISwitch *tempSwitch = (UISwitch *)sender;
    NSIndexPath *indexPath = [self GetIndexPathFromSender:sender];
    
    Outlet *currentOutlet = [self.outlets objectAtIndex:indexPath.row];
    Command *currentCommand = currentOutlet.command;
    NSLog(@"Command on: '%@' Command off: '%@'",currentCommand.on, currentCommand.off);

    if(tempSwitch.on)
    {
        NSLog(@"sending on command: '%@'",currentCommand.on);
        
        AsyncUdpSocket *socket=[[AsyncUdpSocket alloc]initWithDelegate:self];
        NSLog(@"%i",[self.settings.serverPort integerValue]);
        NSString * address = self.settings.serverIP;
        UInt16 port = [self.settings.serverPort integerValue];
        NSData * data = [currentCommand.on dataUsingEncoding:NSUTF8StringEncoding];
        [socket sendData:data toHost:address port:port withTimeout:-1 tag:1];
        
    }else if(!tempSwitch.on)
    {
        NSLog(@"sending off command: '%@'",currentCommand.off);
        
        AsyncUdpSocket *socket=[[AsyncUdpSocket alloc]initWithDelegate:self];
        NSString * address = self.settings.serverIP;
        UInt16 port = [self.settings.serverPort integerValue];
        NSData * data = [currentCommand.off dataUsingEncoding:NSUTF8StringEncoding];
        [socket sendData:data toHost:address port:port withTimeout:-1 tag:1];
        
    }
}

-(NSIndexPath*)GetIndexPathFromSender:(id)sender{
    
    if(!sender) { return nil; }
    
    if([sender isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell *cell = sender;
        return [self.tableView indexPathForCell:cell];
    }
    
    return [self GetIndexPathFromSender:((UIView*)[sender superview])];
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

    }else{
        NSLog(@"there is no current setting");
    }
    
    
}


@end
