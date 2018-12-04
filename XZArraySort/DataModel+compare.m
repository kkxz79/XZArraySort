//
//  DataModel+compare.m
//  XZArraySort
//
//  Created by kkxz on 2018/12/4.
//  Copyright © 2018 kkxz. All rights reserved.
//

#import "DataModel+compare.h"

@implementation DataModel (compare)
-(NSComparisonResult)compareName:(DataModel *)otherModel
{
    NSComparisonResult result = [self.name localizedStandardCompare:otherModel.name];
    return result == NSOrderedDescending;//升序，NSOrderedSame-不变，NSOrderedAscending-降序
}

-(NSComparisonResult)compareAge:(DataModel *)otherModel
{
    NSNumber * number1 = [NSNumber numberWithInt:self.age];
    NSNumber * number2 = [NSNumber numberWithInt:otherModel.age];
    NSComparisonResult result = [number1 compare:number2];
    return result == NSOrderedDescending;//升序，NSOrderedSame-不变，NSOrderedAscending-降序
}

@end
