//
//  FavoriteList.h
//  ApplicazioneApple
//
//  Created by user231383 on 7/9/23.
//

#import <Foundation/Foundation.h>
#import "Favorite.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteList : NSObject

- (long)size;
- (NSArray *)getAll;
- (void)add:(Favorite *)favorite;
- (Favorite *)getAtIndex:(NSInteger)index;
- (void)removeItemAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
