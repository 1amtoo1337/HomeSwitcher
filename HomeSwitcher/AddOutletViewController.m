//
//  AddOutletViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 10.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "AddOutletViewController.h"
#import "OutletInputCell.h"


@interface AddOutletViewController ()

@property (strong,nonatomic) NSArray *cellText;
@property BOOL textEntered;

@end

@implementation AddOutletViewController

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
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.cellText = [[NSArray alloc] initWithObjects:@"Name:",@"Command ON:", @"Command OFF:", nil];
    
    //navigationItem Image
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 98, 34)];
    navigationImage.image=[UIImage imageNamed:@"navTitle.png"];
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 98, 34)];
    [workaroundImageView addSubview:navigationImage];
    self.navigationItem.titleView = workaroundImageView;
    
    self.keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UITextField *outletNameTextField = ((UITextField*)[self.view viewWithTag:100]); //#task#
    [outletNameTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Add Outlet";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    
    // Create label with section title
    UILabel *label = [[UILabel alloc] init];

    NSString *sectionTitle = @"Add Outlet";
    label.frame = CGRectMake(5, 28, 284, 23);
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont fontWithName:@"Avenir" size:17];
    label.text = sectionTitle;
    label.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [view addSubview:label];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellText.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    OutletInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    cell.outletTextField.tag = indexPath.row + 100; //#task#
    cell.outletTextField.delegate = self;
    cell.outletTextField.font = [UIFont fontWithName:@"Avenir" size:19]; //#task#
    [cell.outletTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    cell.outletTextField.placeholder = [self.cellText objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0)
    {
        cell.outletTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    }else
    {
        //commands don't need to be capitalized
        cell.outletTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;

    }
    
       return cell;
}

-(void)textFieldDidChange:(id)sender
{
    NSString *outletName = ((UITextField*)[self.view viewWithTag:100]).text;
    NSString *commandOn = ((UITextField*)[self.view viewWithTag:101]).text;
    NSString *commandOff = ((UITextField*)[self.view viewWithTag:102]).text;

    if(outletName.length > 0 || commandOn.length > 0 || commandOff.length > 0)
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.textEntered = YES;

        
    }else if(outletName.length == 0 || commandOn.length == 0 || commandOff.length == 0)
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.textEntered = NO;

    }
    
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    [self createInputAccessoryView];
    
    // Now add the view as an input accessory view to the selected textfield.
    [textField setInputAccessoryView:self.inputAccView];
    
    // Set the active field. We' ll need that if we want to move properly
    // between our textfields.
    self.txtActiveField = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}


#pragma mark - custom

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
        [self.navigationController popViewControllerAnimated:YES];

    }
}

- (IBAction)cancelOutletEntry:(UIBarButtonItem *)sender
{
    if(self.textEntered == YES)
    {
        [self showAlertView];
        
    }else if(self.textEntered == NO)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)validateInput:(UIBarButtonItem *)sender
{
    
    NSString *outletName = ((UITextField*)[self.view viewWithTag:100]).text;
    NSString *commandOn = ((UITextField*)[self.view viewWithTag:101]).text;
    NSString *commandOff = ((UITextField*)[self.view viewWithTag:102]).text;
    
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
        [self.delegate didSelectWith:self outlet:myOutlet];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark Custom Keyboard Toolbar 
-(void)createInputAccessoryView{
    
    self.inputAccView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 310.0, 40.0)];
    [self.inputAccView setBackgroundColor:[UIColor colorWithRed:217/255.0 green:220/255.0 blue:226/255.0 alpha:1]];
    [self.inputAccView setAlpha: 0.8];
    
    self.btnPrev = [UIButton buttonWithType: UIButtonTypeCustom];
    [self.btnPrev setFrame: CGRectMake(0.0, 0.0, 60.0, 40.0)];
    [self.btnPrev setTitle: @"<" forState: UIControlStateNormal];
    [self.btnPrev setBackgroundColor:[UIColor colorWithRed:217/255.0 green:220/255.0 blue:226/255.0 alpha:1]];
    
    [self.btnPrev addTarget: self action: @selector(gotoPrevTextfield) forControlEvents: UIControlEventTouchUpInside];
    
    // Do the same for the two buttons left.
    self.btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnNext setFrame:CGRectMake(65.0f, 0.0f, 60.0f, 40.0f)];
    [self.btnNext setTitle:@">" forState:UIControlStateNormal];
    [self.btnNext setBackgroundColor:[UIColor colorWithRed:217/255.0 green:220/255.0 blue:226/255.0 alpha:1]];
    [self.btnNext addTarget:self action:@selector(gotoNextTextfield) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnDone setFrame:CGRectMake(240.0, 0.0f, 80.0f, 40.0f)];
    [self.btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [self.btnDone setBackgroundColor:[UIColor colorWithRed:217/255.0 green:220/255.0 blue:226/255.0 alpha:1]];
    [self.btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnDone addTarget:self action:@selector(doneTyping) forControlEvents:UIControlEventTouchUpInside];
    
    [self.inputAccView addSubview:self.btnPrev];
    [self.inputAccView addSubview:self.btnNext];
    //[self.inputAccView addSubview:self.btnDone];
}

-(void)gotoPrevTextfield{
    
    UITextField *txtField1 = ((UITextField*)[self.view viewWithTag:100]);
    UITextField *txtField2 = ((UITextField*)[self.view viewWithTag:101]);
    UITextField *txtField3 = ((UITextField*)[self.view viewWithTag:102]);
    
    if (self.txtActiveField == txtField1)
    {
        self.btnPrev.enabled = NO;
        
        return;
    }
    else if(self.txtActiveField == txtField2)
    {

        [txtField1 becomeFirstResponder];
        
    }else if(self.txtActiveField == txtField3)
    {

        self.btnNext.enabled = YES;
        [txtField2 becomeFirstResponder];
        
        return;
        
    }
}

-(void)gotoNextTextfield
{
    UITextField *txtField1 = ((UITextField*)[self.view viewWithTag:100]);
    UITextField *txtField2 = ((UITextField*)[self.view viewWithTag:101]);
    UITextField *txtField3 = ((UITextField*)[self.view viewWithTag:102]);
    
    if (self.txtActiveField == txtField1)
    {
        [txtField2 becomeFirstResponder];
    }
    else if(self.txtActiveField == txtField2)
    {
        [txtField3 becomeFirstResponder];
        
    }else if(self.txtActiveField == txtField3)
    {
 
        self.btnNext.enabled = NO;
        
        return;
        
    }
}

-(void)doneTyping
{

    [self.txtActiveField resignFirstResponder];
    
}

@end
