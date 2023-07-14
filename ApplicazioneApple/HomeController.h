//
//  ViewController.h
//  ApplicazioneApple
//
//  Created by user231383 on 7/8/23.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *fieldFrom;
@property (weak, nonatomic) IBOutlet UITextField *fieldTo;
@property (weak, nonatomic) IBOutlet UITextField *fieldValue;
@property (weak, nonatomic) IBOutlet UILabel *convertValueLabel;
- (IBAction)convert:(id)sender;

@end

