//
//  FmnAboutUsTVCTableViewController.m
//  Forgetmenots
//
//  Created by Ilya Pimenov on 03.06.14.
//  Copyright (c) 2014 Ilya Pimenov. All rights reserved.
//

#import "FmnSettingsTVC.h"
#import "FmnMisc.h"
#import "ALToastView.h"

@interface FmnSettingsTVC ()

@property (weak, nonatomic) IBOutlet UILabel *teamHeadline;
@property (weak, nonatomic) IBOutlet UITextView *teamBody;
@property (weak, nonatomic) IBOutlet UILabel *whyHeadline;
@property (weak, nonatomic) IBOutlet UITextView *whyBody;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation FmnSettingsTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:nil];
        [sheet addButtonWithTitle:@"Send via Email"];
        [sheet addButtonWithTitle:@"Send via SMS"];
        sheet.tag = 1;
        sheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [sheet showInView:self.view];
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = APPSTORE_LINK;
        [ALToastView toastInView:self.view withText:@"Copied to clipboard"];
    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        if([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController * mail = [[MFMailComposeViewController alloc] init];
            mail.mailComposeDelegate = self;
            [mail setSubject:[@"Feedback on Forgetmenots " stringByAppendingString:[FmnSettings version]]];
            [mail setToRecipients:@[@"ilya.pimenov@gmail.com"]];
            NSString * body = [NSString stringWithFormat:@"\nHardware: %@\nSystem Version: %@\n App Version: %@\nDate: %@", [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion], [FmnSettings version], [NSDate date]];
            [mail setMessageBody:body isHTML:NO];
            
            [self presentViewController:mail animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"E-mail not set"
                                                               message:@"Please set up your e-mail in the Settings"
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alertView show];
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1)
    {
        if (buttonIndex == 1) // Send via Email
        {
            if([MFMailComposeViewController canSendMail]) {
                MFMailComposeViewController * mail = [[MFMailComposeViewController alloc] init];
                mail.mailComposeDelegate = self;
                [mail setSubject:@"Flowers Timeline App"];
                [mail setMessageBody:[@"Give it a look — " stringByAppendingString:APPSTORE_LINK] isHTML:NO];
                [self presentViewController:mail animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"E-mail not set"
                                                                   message:@"Please set up your e-mail in the Settings"
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                [alertView show];
            }
        }
        else if (buttonIndex == 2) // Send via SMS
        {
            if([MFMessageComposeViewController canSendText]) {
                MFMessageComposeViewController * mail = [[MFMessageComposeViewController alloc] init];
                mail.messageComposeDelegate = self;
                [mail setSubject:@"Flowers Timeline App"];
                [mail setBody:[@"Give it a look — " stringByAppendingString:APPSTORE_LINK]];
                [self presentViewController:mail animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Can't send SMS"
                                                                   message:@"Your device cannot send text"
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                [alertView show];
            }
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    [ALToastView toastInView:self.view withText:@"Thank you!"];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    // Ignore errors
    [controller dismissViewControllerAnimated:YES completion:nil];
    [ALToastView toastInView:self.view withText:@"Thank you!"];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *)view;
    tableViewHeaderFooterView.textLabel.textColor = [UIColor whiteColor];
    tableViewHeaderFooterView.backgroundView.backgroundColor = [UIColor clearColor];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Background
    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.versionLabel.text = [FmnSettings version];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
