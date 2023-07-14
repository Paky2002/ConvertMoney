//
//  ConversionFinal.m
//  ApplicazioneApple
//
//  Created by user231383 on 7/9/23.
//

#import <UIKit/UIKit.h>
#import "ConversionFinal.h"

@interface ConversionFinal ()

@end

@implementation ConversionFinal

@synthesize conversionLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];

    conversionLabel.text = [NSString stringWithFormat:@"%ld %@ = %f %@", (long)_valueConversion ,self.from ,  _valueConversion * [self.mutableArray[0] doubleValue], self.to];
    
    self.calledSubView = true;
    
    
    
    self.LineChart.dataPoints = self.mutableArray;
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"conversionDay" forIndexPath:indexPath];
    NSNumber *giorno = self.mutableArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d %@ = %f %@", _valueConversion ,self.from, _valueConversion * [giorno doubleValue], self.to];
    return cell;
}

@end
