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

@protocol JNJProgressButtonDelegate <NSObject>

/** Invoked when the progress button is tapped for the first time, before progress has occured. 
 @param button The instance of the button the event occurred on.
 */
- (void)progressButtonStartButtonTapped:(JNJProgressButton *)button;

/** Invoked when the progress button is tapped after progress has occured. This is an opportunity to perform an action after the progress has completed.
 @param button The instance of the button the event occurred on.
 */
- (void)progressButtonEndButtonTapped:(JNJProgressButton *)button;

/** Invoked when the progress button is tapped while progressing. This is an opportunity to cancel the operation you are displaying progress for.
 @param button The instance of the button the event occurred on.
 */
- (void)progressButtonDidCancelProgress:(JNJProgressButton *)button;

@end

@interface JNJProgressButton : UIView

@property (nonatomic, weak) id<JNJProgressButtonDelegate> delegate;

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, assign) float progress;

@property (nonatomic, strong) UIImage *startButtonImage;
@property (nonatomic, strong) UIImage *endButtonImage;

/** Updates the state of the button to control the button's state.
 @discussion Only will take affect when not already progressing. Can also be used to start the button in it's end state, or to reset the state back to start state.
 */
@property (nonatomic, assign) BOOL needsProgress;

/** Set the current progress of the button
 @param progress The float value of the progress from 0.0 to 1.0. Values outside of this are pinned.
 @param animated Boolean flag to specify if this change should be animated
 */
- (void)setProgress:(float)progress
           animated:(BOOL)animated;

@end
