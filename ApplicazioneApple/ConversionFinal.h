//
//  ConversionFinal.h
//  ApplicazioneApple
//
//  Created by user231383 on 7/9/23.
//

#import <UIKit/UIKit.h>
#import "LineChartView.h"

@interface ConversionFinal : UITableViewController

@property (nonatomic, strong) NSDictionary *dataDictionary; // Aggiungi la dichiarazione della proprietà
@property (nonatomic, strong) NSMutableArray *mutableArray; // Aggiungi la dichiarazione della proprietà
@property (nonatomic, strong) NSString *from; // Aggiungi la dichiarazione della proprietà
@property (nonatomic, strong) NSString *to; // Aggiungi la dichiarazione della proprietà
@property (nonatomic) NSInteger valueConversion; // Aggiungi la dichiarazione della proprietà
@property (weak, nonatomic) IBOutlet UILabel *conversionLabel;
@property (nonatomic) LineChartView *lineChartView;
@property (nonatomic) BOOL calledSubView;
@property (weak, nonatomic) IBOutlet LineChartView *LineChart;

@end
