//
//  NSObject+SYKVO.m
//  zhangshaoyu
//
//  Created by herman on 2017/4/20.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "NSObject+SYKVO.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <UIKit/UIKit.h>

@interface NSObject ()

//@property (nonatomic, copy) void (^singleHandle)(id object);
@property (nonatomic, copy) void (^observerBlock)(NSString *key, id object, NSDictionary *change);
@property (nonatomic, copy) void (^observerBlockText)(id object);

@end

@implementation NSObject (SYKVO)

//- (void)setSingleHandle:(void (^)(id))singleHandle
//{
//    objc_setAssociatedObject(self, @selector(singleHandle), singleHandle, OBJC_ASSOCIATION_COPY);
//}
//
//- (void (^)(id))singleHandle
//{
//    return objc_getAssociatedObject(self, @selector(singleHandle));
//}

//- (void)observerComplete:(void (^)(id object))handle
//{
//    // 设置回调
//    self.singleHandle = [handle copy];
//    
//    // 添加响应者
//    NSString *objectClass = NSStringFromClass([self class]);
//    const char *objectName = [objectClass UTF8String];
//    id theClass = objc_getClass(objectName);
//    
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList(theClass, &outCount);
//    for (i = 0; i < outCount; i++)
//    {
//        objc_property_t property = properties[i];
//        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
//        NSLog(@"propertyName = %@", propertyName);
//        
//        [self addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew context:nil];
//    }
//}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    if (self.singleHandle)
//    {
//        self.singleHandle(object);
//    }
//}


- (void)setObserverBlock:(void (^)(NSString *, id, NSDictionary *))observerBlock
{
    objc_setAssociatedObject(self, @selector(observerBlock), observerBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(NSString *, id, NSDictionary *))observerBlock
{
    return objc_getAssociatedObject(self, @selector(observerBlock));
}

- (void)observerForKeyPath:(NSString *)keyPath complete:(void (^)(NSString *key, id object, NSDictionary *change))complete
{
    self.observerBlock = [complete copy];
    
    [self addObserver:self forKeyPath:keyPath options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (self.observerBlock)
    {
        self.observerBlock(keyPath, object, change);
    }
}


- (void)setObserverBlockText:(void (^)(id))observerBlockText
{
    objc_setAssociatedObject(self, @selector(observerBlockText), observerBlockText, OBJC_ASSOCIATION_COPY);
}

- (void (^)(id))observerBlockText
{
    return objc_getAssociatedObject(self, @selector(observerBlockText));
}

- (void)observerTextEditComplete:(void (^)(id object))complete
{
    self.observerBlockText = [complete copy];
    
    NSString *nameNotification = UITextFieldTextDidChangeNotification;
    if ([self isKindOfClass:[UITextField class]])
    {
        nameNotification = UITextFieldTextDidChangeNotification;
    }
    else if ([self isKindOfClass:[UITextView class]])
    {
        nameNotification = UITextViewTextDidEndEditingNotification;
    }
    
    __weak typeof(self) weakObject = self;
    [[NSNotificationCenter defaultCenter] addObserver:weakObject selector:@selector(textEditChange:) name:nameNotification object:nil];
}

- (void)textEditChange:(NSNotification *)notification
{
    if (self.observerBlockText)
    {
        if ([self isKindOfClass:[UITextField class]])
        {
            UITextField *textfield = (UITextField *)self;
            self.observerBlockText(textfield.text);
        }
        else if ([self isKindOfClass:[UITextView class]])
        {
            UITextView *textfield = (UITextView *)self;
            self.observerBlockText(textfield.text);
        }
    }
}

@end
