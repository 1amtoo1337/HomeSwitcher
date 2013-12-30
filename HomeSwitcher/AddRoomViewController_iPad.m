//
//  AddRoomViewController_iPad.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 30.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "AddRoomViewController_iPad.h"
#import "ProgressHUD.h"

@interface AddRoomViewController_iPad ()

@property (strong, nonatomic) NSArray *sections;
@property (strong,nonatomic) NSMutableArray *outlets;
@property BOOL textEntered;

@end

@implementation AddRoomViewController_iPad

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
    self.outlets = [NSMutableArray array];

    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    self.sections = [[NSArray alloc] initWithObjects:@"Floor", @"Room", nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancelButtonClicked)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Add Room" style:UIBarButtonItemStyleBordered  target:self action:@selector(addRoomButtonClicked)];
    //self.navigationItem.rightBarButtonItem.enabled = NO;
    self.sections = [[NSArray alloc] initWithObjects:@"Room", @"Outlets",  nil];
    
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
    if(section == 1) return self.outlets.count; //room s
    
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
    
    NSLog(@"%@",NSStringFromCGRect(cell.bounds));
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 600, 44)]; //#task#
    //textField.backgroundColor = [UIColor redColor];
    textField.font = [UIFont fontWithName:@"Avenir" size:19]; //#task#
    textField.delegate = self;
    //[textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    textField.placeholder = @"Roomname"; // PLACEHLDR_ADD_ROOM
    //[textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //textField.tag = 11; //#task#
    
    
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        textField.tag = indexPath.row + 300; //#task#
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell addSubview:textField];
        
    }else if(indexPath.section == 0 && indexPath.row == 1)
    {
        textField.tag = indexPath.row + 300;
        textField.text = @"Add Outlet";
        textField.enabled = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cell addSubview:textField];
        
        UIImageView *plus = [[UIImageView alloc] initWithFrame:CGRectMake(480, 5, 30, 30)];
        plus.image = [UIImage imageNamed:@"plus_add_green.png"];
        [cell addSubview:plus];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }else if(indexPath.section == 1)
    {
        textField.text = [[self.outlets objectAtIndex:indexPath.row] objectAtIndex:0]; //commandName
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


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.outlets removeObjectAtIndex:indexPath.row];
        
        [tableView reloadData];
        
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) return NO;
    
    return YES;
    
}


#pragma mark - Segue Stuff

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"floorRoomOutletAddSegue"])
    {
        AddOutletViewController_iPad *vc = [segue destinationViewController];
        vc.delegate = self;
        //vc.importOutlet = [self.outlets objectAtIndex:indexPath.row];
        
    }
}

#pragma mark - Outlet Delegate
-(void)didSelectWith:(AddOutletViewController_iPad *)controller outlets:(NSArray *)theOutlets
{
    
    [self.outlets addObject:theOutlets];
    [ProgressHUD showSuccess:@"Outlet added"];
    [self.tableView reloadData];
    
}


#pragma mark - Custom

-(void)textFieldDidChange:(id)sender
{
    NSString *floorName = ((UITextField*)[self.view viewWithTag:300]).text;
    
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

-(void)addRoomButtonClicked
{
    NSLog(@"adding Room");
    NSString *roomName = ((UITextField*)[self.view viewWithTag:300]).text;
    NSLog(@"Roomnam: %@",roomName);
    //this fuction needs to trigger a delegate method that reloads the listView tableView
    if([roomName isEqualToString:@""] || self.outlets.count == 0)
    {
        NSString *err0 = @"No Roomname specified";
        NSString *err1 = @"No Outlets for room specified";
        
        UIAlertView *alert;
        if([roomName isEqualToString:@""])
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Enter all Fields" message:err0 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }else if (self.outlets.count == 0)
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Enter all Fields" message:err1 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
        
    }else if(![roomName isEqualToString:@""] && self.outlets.count != 0)
    {
        NSArray *arr = [[NSArray alloc] initWithObjects:roomName, self.outlets, nil]; //room: name + outlets
        //[self saveData];
        [self.delegate didFinishRoomInput:self room:arr]; //kasius knaktus
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
    } else if (buttonIndex == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:self];
    }
}

-(void)cancelButtonClicked
{
    NSLog(@"canceling Room input");
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void)saveData
//{
//    NSString *roomName = ((UITextField*)[self.view viewWithTag:300]).text;
//    //    NSString *outletName = ((UITextField*)[self.view viewWithTag:12]).text;
//    //    NSString *outletOn = ((UITextField*)[self.view viewWithTag:13]).text;
//    //    NSString *outletOff = ((UITextField*)[self.view viewWithTag:14]).text;
//    
//    NSMutableArray *allOutlets = [NSMutableArray array];
//    
//    NSManagedObjectContext *context = [self managedObjectContext];
//    Room *room = [NSEntityDescription
//                  insertNewObjectForEntityForName:@"Room"
//                  inManagedObjectContext:context];
//    [room setValue:roomName forKey:@"name"];
//    room.floor = self.floor; //#bug# >
//    
//    for (NSArray *arr in self.outlets)
//    {
//        Outlet *tOutlet =[NSEntityDescription
//                          insertNewObjectForEntityForName:@"Outlet"
//                          inManagedObjectContext:context];
//        tOutlet.name = [arr objectAtIndex:0];
//        tOutlet.stateOn = NO;
//        tOutlet.room = room;
//        
//        Command *tCommand = [NSEntityDescription
//                             insertNewObjectForEntityForName:@"Command"
//                             inManagedObjectContext:context];
//        tCommand.on = [arr objectAtIndex:1];
//        tCommand.off = [arr objectAtIndex:2];
//        tCommand.outlet = tOutlet;
//        tOutlet.command = tCommand;
//        
//        [allOutlets addObject:tOutlet];
//        
//    }
//    
//    [room.outlets setByAddingObjectsFromArray:allOutlets];
//    
//    NSError *error;
//    if (![context save:&error]) {
//        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//    }
//    
//    //[self.delegate didFinishRoomInput:self room:arr]; //kasius knaktus
//    
//}

@end
