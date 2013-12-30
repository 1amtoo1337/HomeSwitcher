//
//  AddFloorAndRoomViewController_iPad.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 29.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "AddFloorAndRoomViewController_iPad.h"
#import "AddRoomViewController_iPad.h"
#import "ProgressHUD.h"
#import "Floor.h"
#import "Room.h"
#import "Outlet.h"
#import "Command.h"
@interface AddFloorAndRoomViewController_iPad ()

@property (strong, nonatomic) NSArray *sections;
@property BOOL textEntered;

@property (strong, nonatomic) NSArray *floor;
@property (strong, nonatomic) NSMutableArray *rooms;
@property (strong, nonatomic) NSMutableArray *outlets;

@end

@implementation AddFloorAndRoomViewController_iPad

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
    
    self.textEntered = NO;
    self.rooms = [NSMutableArray array];

    self.sections = [[NSArray alloc] initWithObjects:@"Floor", @"Room", nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancelButtonClicked)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered  target:self action:@selector(doneButtonClicked)];
    //self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"Add Floor";
    
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sections objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0) return 2; //floor
    if(section == 1) return self.rooms.count; //room s
    
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[textField resignFirstResponder];
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    if(section == 0 && row == 1) NSLog(@"Add");
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 &&indexPath.row == 0) return nil;
    
    return indexPath;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 600, 44)]; //#task#
    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:19];
    textField.font = [UIFont fontWithName:@"Avenir" size:19]; //#task#
    textField.delegate = self;
    //[textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    

    textField.placeholder = @"Floorname"; // PLACEHLDR_ADD_ROOM
        
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        textField.tag = indexPath.row + 200; //#task#
        NSLog(@"Adding 200tag");
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell addSubview:textField];
        
    }else if(indexPath.section == 0 && indexPath.row == 1)
    {
        textField.tag = indexPath.row + 200; //#task#
        textField.text = @"Add Room";
        textField.enabled = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cell addSubview:textField];
        
        UIImageView *plus = [[UIImageView alloc] initWithFrame:CGRectMake(480, 5, 30, 30)];
        plus.image = [UIImage imageNamed:@"plus_add_green.png"];
        [cell addSubview:plus];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    else if(indexPath.section == 1)
    {
        textField.text = [[self.rooms objectAtIndex:indexPath.row] objectAtIndex:0]; //roomName
        textField.enabled = NO;
        [cell addSubview:textField];
    }
    

//    switch(indexPath.section)
//    {
//            //Section 0: Floor
//        case 0:
//            switch (indexPath.row)
//        {
//                case 0:
//
//                break;
//                    
//                default:
//                    break;
//        }
//            
//            //Section 1: Room
//        case 1:
//            switch (indexPath.row)
//        {
//            case 0:
//                ;
//                break;
//                
//            default:
//                break;
//        }
//            
//            default:
//            break;
//    }
    // Configure the cell...
    //cell.textLabel.text = @"asdf";
    
    return cell;
}


-(void)textFieldDidChange:(id)sender
{
    NSString *floorName = ((UITextField*)[self.view viewWithTag:200]).text;
    
    if(floorName.length > 0)
    {
        NSLog(@"text avlbl");
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.textEntered = YES;
        
        
    }else if(floorName.length == 0)
    {
        NSLog(@"no text avlbl");
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.textEntered = NO;
    }
    
}

-(void)doneButtonClicked
{
    NSLog(@"adding Floor");
    [self validateData];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancelButtonClicked
{
    NSLog(@"canceling adding Floor");
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITextField Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

#pragma mark - Segue Stuff

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"floorRoomAddSegue"])
    {
        AddRoomViewController_iPad *vc = [segue destinationViewController];
        vc.delegate = self;
        //vc.importOutlet = [self.outlets objectAtIndex:indexPath.row];
        
    }
}

#pragma mark - Room Delegate
-(void)didFinishRoomInput:(AddRoomViewController_iPad *)controller room:(NSArray *)roomArray
{
    [self.rooms addObject:roomArray];
    [ProgressHUD showSuccess:@"Room added"];
    [self.tableView reloadData];
}

#pragma mark custom

-(void)validateData
{
    NSLog(@"validating data");
    [self saveData];
}

-(void)saveData
{
    NSLog(@"saving data");
    NSString *floorName = ((UITextField*)[self.view viewWithTag:200]).text;
    //    NSString *outletName = ((UITextField*)[self.view viewWithTag:12]).text;
    //    NSString *outletOn = ((UITextField*)[self.view viewWithTag:13]).text;
    //    NSString *outletOff = ((UITextField*)[self.view viewWithTag:14]).text;
    
    NSMutableArray *allRooms = [NSMutableArray array];
    NSMutableArray *allOutlets = [NSMutableArray array];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    Floor *floor = [NSEntityDescription insertNewObjectForEntityForName:@"Floor" inManagedObjectContext:context];
    [floor setValue:floorName forKey:@"name"];
    
    
    /*
     roomsArray -> 
     0: nsstring(roomName)
     1: nsarray(outlets)
        -> 1.0: nsarray(oulet)
            -> 1.0.1: nsstring commandName, 1.0.2: nsstring on, 1.0.3: nsstring off
     */
    //serialization for rooms
    for (NSArray *array in self.rooms)
    {
        //extract roomName
        NSString *roomName = [array objectAtIndex:0];
        NSLog(@"Roomname: %@",roomName);
        
        Room *room = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Room"
                      inManagedObjectContext:context];
        room.floor = floor;
        [room setValue:roomName forKey:@"name"];
        
        for (NSArray *arr in [array objectAtIndex:1])
        {
            //extract outlets
            Outlet *tOutlet =[NSEntityDescription
                              insertNewObjectForEntityForName:@"Outlet"
                              inManagedObjectContext:context];
            tOutlet.name = [arr objectAtIndex:0];
            tOutlet.stateOn = NO;
            tOutlet.room = room;
            
            Command *tCommand = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"Command"
                                 inManagedObjectContext:context];
            tCommand.on = [arr objectAtIndex:1];
            tCommand.off = [arr objectAtIndex:2];
            tCommand.outlet = tOutlet;
            tOutlet.command = tCommand;
            
            [allOutlets addObject:tOutlet];
            
        }
        
        
        [room.outlets setByAddingObjectsFromArray:allOutlets];
        [allRooms addObject:room];
    }
    
    [floor.rooms setByAddingObjectsFromArray:allRooms];

   
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    //[self.delegate didFinishRoomInput:self]; //kasius knaktus <--- must be changed to a custom delegate to have the floor/room table update
    
    //[self.delegate didFinishRoomInput];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"didFinishRoomInputNotification"
     object:self];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
