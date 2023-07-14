//
//  LineChartView.h
//  ApplicazioneApple
//
//  Created by user231383 on 7/9/23.
//

#import <UIKit/UIKit.h>

@interface LineChartView : UIView

@property (nonatomic, strong) NSMutableArray *dataPoints;
@property (nonatomic) double height;
@property (nonatomic) double width;
@property (nonatomic) double padding;
@property (nonatomic) CGContextRef context;

@end
