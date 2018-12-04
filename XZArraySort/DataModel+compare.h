//
//  DataModel+compare.h
//  XZArraySort
//
//  Created by kkxz on 2018/12/4.
//  Copyright © 2018 kkxz. All rights reserved.
//

#import "DataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataModel (compare)
- (NSComparisonResult)compareName:(DataModel *)otherModel;
- (NSComparisonResult)compareAge:(DataModel *)otherModel;

@end

NS_ASSUME_NONNULL_END
