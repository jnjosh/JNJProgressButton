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

@end

@implementation JNJSampleViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.progressButton.delegate = self;
    self.progressButton.tintColor = [UIColor blueColor];
    [self.progressButton setButtonImage:[UIImage imageNamed:@"56-cloud"]
                       highlightedImage:nil
                               forState:JNJProgressButtonStateUnstarted];
    [self.progressButton setButtonImage:[UIImage imageNamed:@"06-magnify"]
                       highlightedImage:nil
                               forState:JNJProgressButtonStateFinished];
}

#pragma mark - JNJProgressButtonDelegate

- (void)progressButtonStartButtonTapped:(JNJProgressButton *)button
{
    NSLog(@"Start Button was tapped");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [NSThread sleepForTimeInterval:3];
        NSInteger index = 0;
        while (index <= 100) {
            [NSThread sleepForTimeInterval:0.125];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.progressButton.progress = (index / 100.0f);
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
