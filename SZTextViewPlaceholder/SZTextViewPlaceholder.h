//
//  SZTextViewPlaceholder.h
//  SZTextViewPlaceHolder
//
//  Created by Steve Zweier on 8/3/13.
//  Copyright (c) 2013 Steven Zweier. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 This is a textview with a placeholder.
 */
@interface SZTextViewPlaceholder : UITextView

/**
 This text you would like to appear as the placeholder.
 */
@property (nonatomic, retain) NSString *placeholder;

/**
 The color of the placeholder.
 */
@property (nonatomic, retain) UIColor *placeholderColor;

/**
 The font of the placeholder
 */
@property (nonatomic, retain) UIFont *placeholderFont;

@end
