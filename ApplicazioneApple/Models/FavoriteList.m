//
//  FavoriteList.m
//  ApplicazioneApple
//
//  Created by user231383 on 7/9/23.
//

#import "FavoriteList.h"

@interface FavoriteList ()

@property (nonatomic, strong) NSMutableArray *list;

@end

@implementation FavoriteList

- (instancetype)init{
    if(self = [super init]){
        _list = [[NSMutableArray alloc] init];
    }
    return self;
}

- (long)size{
    return self.list.count;
}

- (NSArray *)getAll{
    return self.list;
}

- (void)add:(Favorite *)f{
    [self.list addObject:f];
}

- (Favorite *)getAtIndex:(NSInteger)index{
    return [self.list objectAtIndex:index];
}

- (void)removeItemAtIndex:(NSInteger)index {
    if (index >= 0 && index < self.list.count) {
        [self.list removeObjectAtIndex:index];
    }
}

@end
