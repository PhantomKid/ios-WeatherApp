//
//  GlobalVarAndFunc.h
//  Weather
//
//  Created by Kai on 2022/8/25.
//

#ifndef GlobalVarAndFunc_h
#define GlobalVarAndFunc_h

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SET_WIDTH_AS_SCREEN_WIDTH(frame) \
    frame = CGRectMake(frame.origin.x, frame.origin.y, SCREEN_WIDTH, frame.size.height)
#define SET_VALUE_AS_THE_RIGHTMOST_OF_CELL(frame) \
    frame = CGRectMake(SCREEN_WIDTH-frame.size.width, frame.origin.y, frame.size.width, frame.size.height)

#define ADJUST_MID_LABEL_WIDTH(label) \
do { \
    label.textAlignment = NSTextAlignmentCenter; \
label.frame = CGRectMake(SCREEN_WIDTH-[label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName, nil]].width-18, label.frame.origin.y, [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName, nil]].width, label.frame.size.height); \
} while (0)

#define ADJUST_RIGHTMOST_LABEL_WIDTH(label) \
do { \
    label.textAlignment = NSTextAlignmentCenter; \
    label.frame = CGRectMake(SCREEN_WIDTH-[label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName, nil]].width-18, label.frame.origin.y, [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName, nil]].width, label.frame.size.height); \
} while (0)

#endif /* GlobalVarAndFunc_h */
