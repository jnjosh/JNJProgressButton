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

#import "JNJProgressButton.h"

@implementation JNJProgressButton

#pragma mark - Progress

- (void)beginProgressing
{
    // TODO(JNJ): Implement
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    self.progress = progress;
}

#pragma mark - Button Images

- (void)setButtonImage:(UIImage *)image
      highlightedImage:(UIImage *)highlightImage
             forStatus:(JNJProgressButtonStatus)status
{
    // TODO(JNJ): Implement
}

#pragma mark - Actions

- (void)progressButtonWasTapped:(id)sender
{
    if (self.tapAction) {
        self.tapAction(self);
    }
}

#pragma mark - Properties

- (void)setTapAction:(JNJProgressButtonTapAction)tapAction
{
    _tapAction = [tapAction copy];
    
    SEL progressButtonSelector = @selector(progressButtonWasTapped:);
    if (_tapAction) {
        [self addTarget:self action:@selector(progressButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self removeTarget:self action:progressButtonSelector forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
