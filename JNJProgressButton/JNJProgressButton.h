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

#import <UIKit/UIKit.h>

@class JNJProgressButton;

typedef void(^JNJProgressButtonTapAction)(JNJProgressButton *button);

typedef NS_ENUM(NSUInteger, JNJProgressButtonStatus) {
    JNJProgressButtonStatusUnstarted,
    JNJProgressButtonStatusProgressing,
    JNJProgressButtonStatusFinished
};

@interface JNJProgressButton : UIControl

// TODO(JNJ): Better name than status, and state is taken by UIControl
@property (nonatomic, assign, readonly) JNJProgressButtonStatus status;

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, assign) float progress;

@property (nonatomic, copy) JNJProgressButtonTapAction tapAction;

/** Notifies the control that it is about to recieve product updates. This provides the ability to go into a temporary loading state before the progress updates begin */
- (void)beginProgressing;

/** Set the current progress of the button
 @param progress The float value of the progress from 0.0 to 1.0. Values outside of this are pinned.
 @param animated Boolean flag to specify if this change should be animated
 */
- (void)setProgress:(float)progress
           animated:(BOOL)animated;

/** Set the button image
 @param image Image to display in the button for the specified status
 @param highlightImage Image to display in the button for the specified status and is highlighted
 @param status Status identifies when to use the above images. JNJProgressButtonStatusProgressing is ignored as it is generated.
 */
- (void)setButtonImage:(UIImage *)image
      highlightedImage:(UIImage *)highlightImage
             forStatus:(JNJProgressButtonStatus)status;

@end
