//
//  LineChartView.m
//  ApplicazioneApple
//
//  Created by user231383 on 7/9/23.
//

#import <UIKit/UIKit.h>
#import "LineChartView.h"

@interface LineChartView ()

@end

@implementation LineChartView

- (void)drawRect:(CGRect)rect {
    if (self.dataPoints.count < 2) {
        return; // Non ci sono abbastanza punti dati per disegnare il grafico
    }
    
    _context = UIGraphicsGetCurrentContext();
    
    // Configura le caratteristiche del tratto per il grafico
    CGContextSetLineWidth(_context, 1.0);
    CGContextSetStrokeColorWithColor(_context, [UIColor blackColor].CGColor);
    
    // Calcola le dimensioni del grafico
    _width = CGRectGetWidth(rect);
    _height = 400;
    self.padding = 30;
    [self createLineGraph];
    
    NSNumber *minimumValue = [self.dataPoints valueForKeyPath:@"@min.self"];
    NSNumber *maximumValue  = [self.dataPoints valueForKeyPath:@"@max.self"];
    NSNumber *interval =  [NSNumber numberWithDouble:maximumValue.doubleValue - minimumValue.doubleValue];

    // Disegna il grafico lineare
    for (NSUInteger i = 0; i < self.dataPoints.count - 1; i++) {
        
        CGPoint startPoint = CGPointMake(((_width - _padding)/8 * i) + _padding, (CGFloat)((((maximumValue.doubleValue - [self.dataPoints[i] doubleValue]) / interval.doubleValue) * (_height - _padding * 2)) + _padding ));
        CGPoint endPoint = CGPointMake(((_width - _padding)/8 * (i + 1)) + _padding, (CGFloat)((((maximumValue.doubleValue - [self.dataPoints[i+1] floatValue]) / interval.doubleValue) * (_height - _padding * 2 )) + _padding));

        CGContextMoveToPoint(_context, startPoint.x, startPoint.y);
        CGContextAddLineToPoint(_context, endPoint.x, endPoint.y);
    }
    
    // Disegna il tracciato del grafico
    CGContextStrokePath(_context);
}

- (void) createLineGraph {
    
    //Disegno asse delle X
    
    CGPoint startPoint = CGPointMake(_padding, _height - _padding + 20 );
    CGPoint endPoint = CGPointMake(_padding, _padding);
    CGContextMoveToPoint(_context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(_context, endPoint.x, endPoint.y);
    
    //Disegno asse delle X

    
    startPoint = CGPointMake(_padding - 20, _height - _padding );
    endPoint = CGPointMake(_width - _padding, _height - _padding);
    CGContextMoveToPoint(_context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(_context, endPoint.x, endPoint.y);
    
}

@end

