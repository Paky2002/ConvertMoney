//
//  ViewController.h
//  ApplicazioneApple
//
//  Created by user231383 on 7/8/23.
//

#import <UIKit/UIKit.h>
#import "FavoriteList.h"

@interface ConversController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *fieldFrom;
@property (weak, nonatomic) IBOutlet UITextField *fieldTo;
@property (weak, nonatomic) IBOutlet UITextField *fieldValue;
@property (weak, nonatomic) IBOutlet UILabel *convertValueLabel;
@property (nonatomic, strong) FavoriteList *favorites;
@property (nonatomic, strong) NSMutableArray *dataArray;
- (IBAction)convert:(id)sender;
- (IBAction)addOnTable:(id)sender;


@end

