//
//  SZTextViewPlaceholder.m
//  SZTextViewPlaceHolder
//
//  Created by Steve Zweier on 8/3/13.
//  Copyright (c) 2013 Steven Zweier. All rights reserved.
//

#import "SZTextViewPlaceholder.h"

#define kPlaceHolderTag 777

@interface SZTextViewPlaceholder ()

@property (nonatomic, strong) UITextView *placeHolderTextView;

@end

@implementation SZTextViewPlaceholder

- (void)awakeFromNib
{
  [super awakeFromNib];
  
  /**
   Initialize the view
   */
  [self initializeView];
}

- (id)initWithFrame:(CGRect)frame
{
  if( (self = [super initWithFrame:frame]) )
  {
    /**
     Initiliaze the view
     */
    [self initializeView];
    
  }
  return self;
}

- (void)initializeView{
  /**
   Set the default placeholder color to light gray
   */
  [self setPlaceholderColor:[UIColor lightGrayColor]];
  
  /**
   Register for notifications when the textview changed
   */
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
}

/**
 Called when the placeholder color is set
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
  /**
   Store the placeholder color
   */
  _placeholderColor = placeholderColor;
  
  if(!_placeHolderTextView){
    /**
     Placeholder doesn't exist, create it.
     */
    [self createPlaceholder];
  }else{
    /**
     Placeholder does exist, update it.
     */
    [_placeHolderTextView setTextColor:self.placeholderColor];
    [_placeHolderTextView setText:self.placeholder];
  }
}

/**
 Called when placeholder is set
 */
- (void)setPlaceholder:(NSString *)placeholder{
  /**
   Store the placeholder
  */
  _placeholder = placeholder;
  
  if(!_placeHolderTextView){
    /**
     Placeholder doesn't exist, create it.
     */
    [self createPlaceholder];
  }else{
    /**
     Placeholder does exist, update it.
     */
    [_placeHolderTextView setTextColor:self.placeholderColor];
    [_placeHolderTextView setText:self.placeholder];
  }
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont{
  _placeholderFont = placeholderFont;
  [_placeHolderTextView setFont:[self placeholderFont]];
}

/**
 Create the placeholder
 */
- (void)createPlaceholder{
  if([[self placeholder] length] > 0)
  {
    /**
     If we have a placeholder check if we made the placeholder text view.
     */
    if (!_placeHolderTextView)
    {
      /**
       The placeholder textview doesn't exist
       We need to create it and add it to the textview
       */
      _placeHolderTextView = [[UITextView alloc] initWithFrame:self.bounds];
      [_placeHolderTextView setTag:kPlaceHolderTag];
      [_placeHolderTextView setBackgroundColor:[UIColor clearColor]];
      [_placeHolderTextView setTextColor:self.placeholderColor];
      [_placeHolderTextView setFont:self.font];
      [self insertSubview:_placeHolderTextView atIndex:0];
      [_placeHolderTextView setHidden:NO];
      [_placeHolderTextView setUserInteractionEnabled:NO];
    }
    /**
     Set the text to the placeholder text
     */
    _placeHolderTextView.text = self.placeholder;
  }
}

/**
 This method is called when the textview did change
 */
- (void)textViewDidChange:(NSNotification *)notification
{
  if([[notification object] isEqual:self]){
    if([[self placeholder] length] == 0)
    {
      /**
       The placeholder wasn't set so forget it
       */
      return;
    }
    
    if([[self text] length] == 0 && [[self viewWithTag:kPlaceHolderTag] isHidden])
    {
      /**
       The textview has no text (empty) and the placeholder is hidden, show the placeholder
       */
      [[self viewWithTag:kPlaceHolderTag] setHidden:NO];
    }
    else if([[self text] length] != 0 && ![[self viewWithTag:kPlaceHolderTag] isHidden])
    {
      /**
       The text view has text and the placeholder is not hidden, hide the placeholder
       */
      [[self viewWithTag:kPlaceHolderTag] setHidden:YES];
    }
  }
}

/**
 This sets the text of the textview.
 
 When this happens we call textviewdidchange to adjust the placeholder accordingly
 */
- (void)setText:(NSString *)text {
  [super setText:text];
  [self textViewDidChange:nil];
}

/**
 This sets the font for the textview.
 
 When this happens we want the placeholder to be the same font so we adjust the placeholderes
 */
- (void)setFont:(UIFont *)font{
  [super setFont:font];
  [self adjustPlaceholderFont];
}

/**
 We want the font of the placeholder to match that of the textview
 */
- (void)adjustPlaceholderFont{
  if(_placeHolderTextView && ![self placeholderFont]){
    /**
     Set the placeholder font to match the our textviews new font if a different font hasn't been set
     */
    [_placeHolderTextView setFont:self.font];
  }
}

/**
 If a new frame is set for the textview the placeholder should match it as well
 */
- (void)setFrame:(CGRect)frame{
  [_placeHolderTextView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
  [super setFrame:frame];
}

/**
 Deallocates the project and removes the current observers.
 
 We also release necessary objects if this is being used without arc.
 */
- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
#if !__has_feature(objc_arc)
  [_placeHolderTextView release]; _placeHolderTextView = nil;
  [_placeholderColor release]; _placeholderColor = nil;
  [_placeholder release]; _placeholder = nil;
  [super dealloc];
#endif
}

@end
