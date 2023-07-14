//
//  ErrorAlertView.m
//  ApplicazioneApple
//
//  Created by user231383 on 7/11/23.
//

#import <Foundation/Foundation.h>
#import "ErrorAlertView.h"
#import <UIKit/UIKit.h>


@interface ErrorAlertView ()

@end

@implementation ErrorAlertView

+ (instancetype)alertWithTitle:(NSString *)title {
    ErrorAlertView *alert = [self alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:dismissAction];
    return alert;
}

- (void)show:(NSString *)message viewController:(UIViewController *)controller {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    [rootViewController presentViewController:self animated:YES completion:nil];
}

@end
