//
//  VCButtonUtil.m
//  Demo
//
//  Copyright (C) 2011 by Vinay Chavan
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "VCButtonUtil.h"

@implementation VCButtonUtil

+ (UIImage *)backgroundImageForStyle:(BarButtonType)type
{
	UIImage *image = nil;
	
	switch (type) {
		case BarButtonNormal:
			image = [[UIImage imageNamed:@"normalBarButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)];
			break;
		case BarButtonBack:
			image = [[UIImage imageNamed:@"backBarButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
			break;
	}
	
	return image;
}

+ (UIImage *)pressedBackgroundImageForStyle:(BarButtonType)type
{
	UIImage *image = nil;
	
	switch (type) {
		case BarButtonNormal:
			image = [[UIImage imageNamed:@"normalBarButtonHighlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 7, 0, 7)];
			break;
		case BarButtonBack:
			image = [[UIImage imageNamed:@"backBarButtonHighlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
			break;
	}
	
	return image;
}

+ (id)buttonWithType:(BarButtonType)type target:(id)target selector:(SEL)selector
{
	UIImage *buttonImage = [self backgroundImageForStyle:type];
	UIImage *buttonPressedImage = [self pressedBackgroundImageForStyle:type];
	
	//	CGFloat height = 30;
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0.0, 0.0, 0.0, buttonImage.size.height);
	button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
	button.titleLabel.shadowOffset = CGSizeMake(0, -1);
	button.titleLabel.shadowColor = [UIColor darkGrayColor];
	
	if (type == BarButtonBack) {
		[button setContentEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 10)];
	}else {
		[button setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
	}
	
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
	[button setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
	[button setBackgroundImage:buttonPressedImage forState:UIControlStateSelected];
	button.adjustsImageWhenHighlighted = NO;
	
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	
	return button;
}

+ (id)buttonWithTitle:(NSString *)title type:(BarButtonType)type target:(id)target selector:(SEL)selector
{
	UIButton *button = [self buttonWithType:type target:target selector:selector];
	
	[button setTitle:title forState:UIControlStateNormal];
	[button sizeToFit];
	
	return button;
}

+ (id)buttonWithImage:(UIImage *)image type:(BarButtonType)type target:(id)target selector:(SEL)selector;
{
	UIButton *button = [self buttonWithType:type target:target selector:selector];
	
	[button setImage:image forState:UIControlStateNormal];
	[button sizeToFit];
	
	return button;
}

+ (id)barButtonWithTitle:(NSString *)title type:(BarButtonType)type target:(id)target selector:(SEL)selector
{
	UIButton *button = [self buttonWithTitle:title type:type target:target selector:selector];
	return [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
}

+ (id)barButtonWithImage:(UIImage *)image type:(BarButtonType)type target:(id)target selector:(SEL)selector
{
	UIButton *button = [self buttonWithImage:image type:type target:target selector:selector];
	return [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
}

@end