//
//  Favorite.m
//  ApplicazioneApple
//
//  Created by user231383 on 7/9/23.
//

#import <Foundation/Foundation.h>
#import "Favorite.h"

@implementation Favorite

- (instancetype)initFavorite:(NSString *)from
                         to:(NSString *)to
                            {
    if(self = [super init]){
        _from = [from copy];
        _to = [to copy];
    }
    return self;
}

- (NSString *)displayFavorite{
    return [NSString stringWithFormat:@"%@ %@", self.from, self.to];
}

@end
