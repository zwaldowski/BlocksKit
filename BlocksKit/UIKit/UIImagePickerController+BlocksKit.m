//
//  UIImagePickerController+BlocksKit.m
//  BlocksKit
//
//  Created by Yas Kuraishi on 2/20/14.
//  Copyright (c) 2014 Pandamonia LLC. All rights reserved.
//

#import "A2DynamicDelegate.h"
#import "NSObject+A2BlockDelegate.h"
#import "UIImagePickerController+BlocksKit.h"

#pragma mark Custom delegate

@interface A2DynamicUIImagePickerControllerDelegate : A2DynamicDelegate <UIImagePickerControllerDelegate>

@end

@implementation A2DynamicUIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)])
		[realDelegate imagePickerController:picker didFinishPickingMediaWithInfo:info];
    
	void (^block)(UIImagePickerController *, NSDictionary *) = [self blockImplementationForMethod:_cmd];
	if (block) block(picker, info);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(imagePickerControllerDidCancel:)])
		[realDelegate imagePickerControllerDidCancel:picker];
    
	void (^block)(UIImagePickerController *) = [self blockImplementationForMethod:_cmd];
	if (block) block(picker);
}

@end

#pragma mark Category

@implementation UIImagePickerController (BlocksKit)

@dynamic bk_didFinishPickingMediaBlock;
@dynamic bk_didCancelBlock;

+ (void)load
{
	@autoreleasepool {
		[self bk_registerDynamicDelegate];
		[self bk_linkDelegateMethods:@{ @"bk_didFinishPickingMediaBlock": @"imagePickerController:didFinishPickingMediaWithInfo:",
                                        @"bk_didCancelBlock": @"imagePickerControllerDidCancel:" }];
	}
}

@end
