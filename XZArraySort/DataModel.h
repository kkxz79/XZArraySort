//
//  DataModel.h
//  XZArraySort
//
//  Created by kkxz on 2018/12/4.
//  Copyright © 2018 kkxz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,assign)BOOL sex;
@property(nonatomic,assign)double height;
@property(nonatomic,assign)int age;
@end

NS_ASSUME_NONNULL_END
