//
//  ViewController.m
//  TextViewPlaceHolder
//
//  Created by Steve Zweier on 8/3/13.
//  Copyright (c) 2013 Steven Zweier. All rights reserved.
//

#import "ViewController.h"
#import "SZTextViewPlaceholder.h"

@interface ViewController ()
{
  SZTextViewPlaceholder *szTextView2;
}

@property (weak, nonatomic) IBOutlet SZTextViewPlaceholder *szTextView;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  /**
   Example of SZTextViewPlaceholder created in the Main.storyboard
   */
  [self.szTextView setPlaceholder:@"Placeholder"];
  [self.szTextView setPlaceholderColor:[UIColor lightGrayColor]];
  [self.szTextView setTextColor:[UIColor blackColor]];
  
  /**
   Example of SZTableViewPlaceholder initialization in code
   */
  szTextView2 = [[SZTextViewPlaceholder alloc] init];
  [szTextView2 setFrame:CGRectMake(0, self.szTextView.frame.origin.y+self.szTextView.frame.size.height+10, 320, 100)];
  [szTextView2 setPlaceholder:@"Placeholder text to show the capability of the textview to show a multi-line placeholder."];
  [szTextView2 setPlaceholderColor:[UIColor lightGrayColor]];
  [szTextView2 setTextColor:[UIColor blackColor]];
  [szTextView2 setPlaceholderFont:[UIFont fontWithName:@"Arial-ItalicMT" size:10]];
  [self.view addSubview:szTextView2];
}

@end
