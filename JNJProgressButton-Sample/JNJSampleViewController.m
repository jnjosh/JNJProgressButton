/*
 JNJProgressButton
 
 Copyright (c) 2013 Josh Johnson <jnjosh@jnjosh.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "JNJSampleViewController.h"
#import "JNJProgressButton.h"

@interface JNJSampleViewController () <JNJProgressButtonDelegate>

@property (nonatomic, weak) IBOutlet JNJProgressButton *progressButton;
@property (weak, nonatomic) IBOutlet JNJProgressButton *progressButton2;
@property (weak, nonatomic) IBOutlet JNJProgressButton *progressButton3;

@end

@implementation JNJSampleViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.progressButton.delegate = self;
    self.progressButton.tintColor = [UIColor blueColor];
    self.progressButton.startButtonImage = [UIImage imageNamed:@"56-cloud"];
    self.progressButton.endButtonImage = [UIImage imageNamed:@"06-magnify"];
    
    self.progressButton2.delegate = self;
    self.progressButton2.tintColor = [UIColor greenColor];
    self.progressButton2.startButtonImage = [UIImage imageNamed:@"56-cloud"];
    self.progressButton2.endButtonImage = [UIImage imageNamed:@"06-magnify"];

    self.progressButton3.delegate = self;
    self.progressButton3.tintColor = [UIColor redColor];
    self.progressButton3.startButtonImage = [UIImage imageNamed:@"56-cloud"];
    self.progressButton3.endButtonImage = [UIImage imageNamed:@"06-magnify"];
    self.progressButton3.needsProgress = NO;
}

#pragma mark - Actions

- (IBAction)resetProgressButton:(id)sender
{
    self.progressButton.needsProgress = YES;
    self.progressButton2.needsProgress = YES;
}

- (IBAction)showActionSheet:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Test", @"Test 1", nil];
    [sheet showInView:self.view];
}

#pragma mark - JNJProgressButtonDelegate

- (void)progressButtonStartButtonTapped:(JNJProgressButton *)button
{
    NSLog(@"Start Button was tapped");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [NSThread sleepForTimeInterval:3];
        NSInteger index = 0;
        while (index <= 100) {
            [NSThread sleepForTimeInterval:0.04];
            dispatch_async(dispatch_get_main_queue(), ^{
                button.progress = (index / 100.0f);
            });
            index++;
        }
    });
}

- (void)progressButtonEndButtonTapped:(JNJProgressButton *)button
{
    NSLog(@"End Button was tapped");
}

- (void)progressButtonDidCancelProgress:(JNJProgressButton *)button
{
    NSLog(@"Button was canceled");
}

@end
