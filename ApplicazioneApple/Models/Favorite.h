//
//  Favorite.h
//  ApplicazioneApple
//
//  Created by user231383 on 7/9/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Favorite : NSObject

- (instancetype)initFavorite:(NSString *)from
                         to:(NSString *)to;

@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSString *to;

@property (nonatomic, readonly) NSString *displayFavorite;

@end

NS_ASSUME_NONNULL_END

