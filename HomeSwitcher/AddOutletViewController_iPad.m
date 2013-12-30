//
//  AddOutletViewController_iPad.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 30.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "AddOutletViewController_iPad.h"

@interface AddOutletViewController_iPad ()

@property (strong,nonatomic) NSArray *cellText;
@property BOOL textEntered;

@end

@implementation AddOutletViewController_iPad

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

    [self.navigationItem setHidesBackButton:YES animated:YES];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancelButtonClicked)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Add Outlet" style:UIBarButtonItemStyleBordered  target:self action:@selector(addOutletButtonClicked)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.cellText = [[NSArray alloc] initWithObjects:@"Name:",@"Command ON:", @"Command OFF:", nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UITextField *outletNameTextField = ((UITextField*)[self.view viewWithTag:400]); //#task#
    [outletNameTextField becomeFirstResponder];
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
    return self.cellText.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 600, 44)]; //#task#
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    textField.tag = indexPath.row + 400; //#task#
    textField.font = [UIFont fontWithName:@"Avenir" size:19]; //#task#
    textField.delegate = self;
    textField.placeholder = [self.cellText objectAtIndex:indexPath.row];
    [cell addSubview:textField];
    
    return cell;
}


-(void)textFieldDidChange:(id)sender
{
    NSString *outletName = ((UITextField*)[self.view viewWithTag:400]).text;
    NSString *commandOnName = ((UITextField*)[self.view viewWithTag:401]).text;
    NSString *commandOffName = ((UITextField*)[self.view viewWithTag:402]).text;
    
    if(outletName.length > 0 || commandOnName.length > 0 || commandOffName.length > 0)
    {
        NSLog(@"text avlbl");
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.textEntered = YES;
        
        
    }else if(outletName.length == 0 || commandOnName.length == 0 || commandOffName.length == 0)
    {
        NSLog(@"no text avlbl");
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.textEntered = NO;
    }
    
}

-(void)cancelButtonClicked
{
    NSLog(@"canceling Outlet input");
    if(self.textEntered == YES)
    {
        [self showAlertView];
        
    }else if(self.textEntered == NO)
    {
        [self.navigationController popViewControllerAnimated:YES];
        //popToRootViewControllerAnimated:YES];
    }
}

-(void)showAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cancel?" message:@"Do you really want to cancel ?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"cancel");
    } else if (buttonIndex == 1)
    {
        NSLog(@"ok");
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}

-(void)addOutletButtonClicked
{
    NSLog(@"adding Outlet");
    
    NSString *outletName = ((UITextField*)[self.view viewWithTag:400]).text;
    NSString *commandOn = ((UITextField*)[self.view viewWithTag:401]).text;
    NSString *commandOff = ((UITextField*)[self.view viewWithTag:402]).text;
    
    //this fuction needs to trigger a delegate method that reloads the listView tableView
    if([outletName isEqualToString:@""] || [commandOn isEqualToString:@""] || [commandOff isEqualToString:@""])
    {
        NSString *err0 = @"No Outletname specified";
        NSString *err1 = @"Please specify Command ON";
        NSString *err2 = @"Please specify Command OFF";
        
        //not all fields were entered
        UIAlertView *alert;
        if([outletName isEqualToString:@""])
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Enter all Fields" message:err0 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }else if ([commandOn isEqualToString:@""])
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Enter all Fields" message:err1 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }else if ([commandOff isEqualToString:@""])
        {
            alert = [[UIAlertView alloc] initWithTitle:@"Enter all Fields" message:err2 delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
        
    }else if(![outletName isEqualToString:@""] && ![commandOn isEqualToString:@""] && ![commandOff isEqualToString:@""])
    {
        
        /*
         create an outlet object, save it in core data, delegate it to the parent view controller
         if the room gets saved attach it to the corresponding room, if not delete the outlets
         first, before dismissing the input process
         
         #task#
         */
        NSArray *myOutlet = [NSArray arrayWithObjects:outletName, commandOn, commandOff, nil];
        [self.delegate didSelectWith:self outlets:myOutlet];
        
        [self.navigationController popViewControllerAnimated:YES];
    }

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
