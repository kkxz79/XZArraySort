//
//  ViewController.m
//  XZArraySort
//
//  Created by kkxz on 2018/12/4.
//  Copyright © 2018 kkxz. All rights reserved.
//https://www.jianshu.com/p/2fa53fa56dcc

#import "ViewController.h"
#import "DataModel.h"
#import "DataModel+compare.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //假数据生成
    NSArray *nameArray = @[@"小白", @"大白", @"老白", @"艾尔", @"黑山", @"张三", @"李四", @"王五", @"范晶", @"荆南", @"昔日", @"安安"];
    NSArray *ageArray = @[@3, @32, @45, @22, @32, @27, @15, @22, @55, @34, @32, @22];
    NSArray *heightArray = @[@100, @166, @180, @165, @163, @176, @174, @183, @186, @178, @167, @160];
    NSMutableArray *originalArray = [NSMutableArray arrayWithCapacity:nameArray.count];
    for (int i = 0; i<nameArray.count; i++) {
        DataModel *model = [[DataModel alloc]init];
        model.name = nameArray[i];
        model.age = [ageArray[i] intValue];
        model.height = [heightArray[i] doubleValue];
        [originalArray addObject:model];
    }
    
    //输出数组元素
    for (DataModel *model in originalArray) {
        NSLog(@"age: %d,height: %.1f name: %@", model.age,model.height, model.name);
    }
    
    NSLog(@"------------------------------------------");
    
    //倒序输出
    /*
     在Array的扩展类(NSExtendedArray)中提供了reverseObjectEnumerator方法
     通过NSEnumerator的扩展类(NSExtendedEnumerator)中的allObjects属性，将其转化为Array类对象。
     */
    originalArray = (NSMutableArray*)[[originalArray reverseObjectEnumerator] allObjects];
    for (DataModel *model in originalArray) {
        NSLog(@"反序##age: %d,height: %.1f name: %@", model.age,model.height, model.name);
    }
    
    NSLog(@"------------------------------------------");
    //升序、降序
    /*
     NSArray的排序方法(sortedArrayUsingSelector:)是生成一个排好序的新数组。
     NSMutableArray的排序可以直接对该数组进行排序(sortUsingSelector:),也可以生成新数组(sortedArrayUsingSelector: ),而原数组不变。
     NSString类具有(compare:)、(caseInsensitiveCompare:)、(localizedStandardCompare:)方法。
     compare:区分大小写
     caseInsensitiveCompare: 不区分大小写
     localizedStandardCompare:根据当前语言环境的语言规则进行排序（语言环境可能会根据大小写，变音符号等等的顺序而发生改变）
     基本数据类型如int, double等, 可使用NSNumber类具有的(compare:)方法。
     */
    
    //字符串数组
    NSMutableArray * newNameArray = [NSMutableArray arrayWithArray:nameArray];
    [newNameArray addObjectsFromArray:@[@"Smith",@"Bohn",@"aohn",@"john"]];
    NSArray * resultNameArray = [newNameArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    // 输出排序结果
    for (NSString *name in resultNameArray) {
        NSLog(@"name: %@",name);//先按拼音排序，再按字母排序，不区分大小写
    }
    NSLog(@"------------------------------------------");
    //int类型数组
    NSArray * resultAgeArray = [ageArray sortedArrayUsingSelector:@selector(compare:)];
    // 输出排序结果
    for (NSNumber *age in resultAgeArray) {
        NSLog(@"age: %@",age);
    }
    
    NSLog(@"------------------------------------------");
    //数组元素为模型对象或字典类型时，需要自定义排序方法
    //根据name属性进行排序
    NSArray * resultStrArray = [originalArray sortedArrayUsingSelector:@selector(compareName:)];
    for (DataModel *model in resultStrArray) {
        NSLog(@"自定义-Name## age: %d,height: %.1f name: %@", model.age,model.height, model.name);
    }
    
     NSLog(@"------------------------------------------");
    //根据age属性进行排序
    NSArray * resultNumArray = [originalArray sortedArrayUsingSelector:@selector(compareAge:)];
    // 输出排序结果
    for (DataModel *model in resultNumArray) {
        NSLog(@"自定义-Age## age: %d,height: %.1f name: %@", model.age,model.height, model.name);
    }
    
     NSLog(@"------------------------------------------");
    //sortedArrayUsingComparator  、sortUsingComparator
    /*
     NSArray的排序方法(sortedArrayUsingComparator:)是生成一个排好序的新数组。
     NSMutableArray的排序可以直接对该数组进行排序(sortUsingComparator:),也可以生成新数组(sortedArrayUsingComparator: ),而原数组不变。
     */
    /*
     如果待比较的属性是字符串(NSString)类型, 使用其默认的方法: localizedStandardCompare: 它将根据当前语言环境的语言规则进行排序（语言环境可能会根据大小写，变音符号等等的顺序而发生改变）
     */
    NSArray * resultCompArray = [originalArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        DataModel * model1 = obj1;
        DataModel * model2 = obj2;
        NSComparisonResult result = [model1.name localizedStandardCompare:model2.name];
        return result == NSOrderedDescending;//升序
    }];
    // 输出排序结果
    for (DataModel *model in resultCompArray) {
        NSLog(@"sortedArrayUsingComparator ## age: %d,height: %.1f name: %@", model.age,model.height, model.name);
    }
    
    NSLog(@"------------------------------------------");
    //如果待比较的属性是其他的类型, 比如int, double等, 就需要对将其转化为NSNumber类型
    NSArray * resultNumberArray = [originalArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        DataModel * model1 = obj1;
        DataModel * model2 = obj2;
        NSNumber * number1 = [NSNumber numberWithInt:model1.age];
        NSNumber * number2 = [NSNumber numberWithInt:model2.age];
        NSComparisonResult result = [number1 compare:number2];
        return result == NSOrderedDescending;//升序
    }];
    // 输出排序结果
    for (DataModel *model in resultNumberArray) {
        NSLog(@"常量数据类型 ## age: %d,height: %.1f name: %@", model.age,model.height, model.name);
    }
    
    NSLog(@"------------------------------------------");
    //sortedArrayUsingDescriptors & sortUsingDescriptors
    /*
     NSArray的排序方法(sortedArrayUsingDescriptors:)是生成一个排好序的新数组。
     NSMutableArray的排序可以直接对该数组进行排序(sortUsingDescriptors:),也可以生成新数组(sortedArrayUsingDescriptors: ),而原数组不变。
     */
    //创建排序规则NSSortDescriptor
    //key :按照age属性 升序排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    //给数组添加排序规则
    [originalArray sortUsingDescriptors:@[sort]];
    // 输出排序结果
    for (DataModel *model in originalArray) {
        NSLog(@"NSSortDescriptor ## age: %d,height: %.1f name: %@", model.age,model.height, model.name);
    }
    
    NSLog(@"------------------------------------------");
    //可同时制定多个规则：其优先级取决于在数组中的先后顺序
    //创建排序规则NSSortDescriptor
    //key :按照age属性 升序排序
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    //age 相同 按照height属性 升序排序
    NSSortDescriptor *sort2 = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];
    //给数组添加排序规则
    [originalArray sortUsingDescriptors:@[sort1,sort2]];
    for (DataModel *model in originalArray) {
        NSLog(@"NSSortDescriptor 组合 ## age: %d,height: %.1f name: %@", model.age,model.height, model.name);
    }
    /** 其中age相同的按照height属性 升序排序
     age: 22,height: 160.0 name: 安安
     age: 22,height: 165.0 name: 艾尔
     age: 22,height: 183.0 name: 王五
     
     age: 32,height: 163.0 name: 黑山
     age: 32,height: 166.0 name: 大白
     age: 32,height: 167.0 name: 昔日
     */
    
     NSLog(@"------------------------------------------");
    /*
     sortedArrayUsingFunction:context &
     sortedArrayUsingFunction:context:hint &
     sortUsingFunction:context & sortUsingFunction:context:hint
     comparator:基于函数指针的自定义函数
     context:上下文，通常为NuLL
     hint：加速排序，同sortedArrayHint
    */
    /*
     注:hinted sort 方式在你有一个已排序的大数组 (N 个元素) 并且只改变其中一小部分（P 个添加和删除，这里 P远小于 N）时，会非常有效。
     你可以重用原来的排序结果，然后在 N 个老项目和 P 个新项目进行一个概念上的归并排序。
     为了得到合适的 hint，你应该在原来的数组排序后使用 sortedArrayHint 来在你需要的时候(比如在数组改变后想重新排序时)保证持有它。
     */
    NSArray * resByAgeArray = [originalArray sortedArrayUsingFunction:compareByAge context:nil];
    for (DataModel * model in resByAgeArray){
        NSLog(@"age: %d,height: %.1f name: %@", model.age,model.height, model.name);
    }
    
    /*
     总结：
     数组元素为字符串或基本数据类型时，推荐使用系统定义的函数进行排序sortedArrayUsingSelector & sortUsingSelector
     需要通过多个key进行排序时，推荐使用sortedArrayUsingDescriptors & sortUsingDescriptors
     比较方法复杂时，推荐使用sortedArrayWithOptions: usingComparator & sortWithOptions: usingComparator或sortedArrayUsingComparator & sortUsingComparator
     */
    
}

//定义一个函数方法
NSInteger compareByAge(id obj1,id obj2,void*context) {
    DataModel * model1 = obj1;
    DataModel * model2 = obj2;
    NSNumber * number1 = [NSNumber numberWithInt:model1.age];
    NSNumber * number2 = [NSNumber numberWithInt:model2.age];
    NSComparisonResult result = [number1 compare:number2];
    return result == NSOrderedDescending;//升序
}


@end
