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

#define SET_HEIGHT_USING_GOLDEN_SECTION(frame, y0, n) \
    frame = CGRectMake(0.0, y0, frame.size.width, 0.618*SCREEN_HEIGHT/n); \
    y0 += 0.618*SCREEN_HEIGHT/n

#define SET_WIDTH_AS_SCREEN_WIDTH(frame) \
    frame = CGRectMake(frame.origin.x, frame.origin.y, SCREEN_WIDTH, frame.size.height)

#define SET_WIDTH_AND_HEIGHT_TOGETHER_USING_HEIGHT_GOLDEN_SECTION(frame, y0, n) \
    frame = CGRectMake(0.0, y0, SCREEN_WIDTH, 0.618*SCREEN_HEIGHT/n); \
    y0 += 0.618*SCREEN_HEIGHT/n

#define INIT_CELL(cell, fontSize) \
cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil]; \
[cell.textLabel setFont:[UIFont systemFontOfSize:fontSize]]; \
[cell.detailTextLabel setFont:[UIFont systemFontOfSize:fontSize]]; \

#define ADJUST_MID_LABEL_WIDTH(label) \
do { \
    label.textAlignment = NSTextAlignmentCenter; \
label.frame = CGRectMake(SCREEN_WIDTH-[label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName, nil]].width-17, label.frame.origin.y, [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName, nil]].width, label.frame.size.height); \
} while (0)

#define ADJUST_RIGHTMOST_LABEL_WIDTH(label) \
do { \
    label.textAlignment = NSTextAlignmentCenter; \
    label.frame = CGRectMake(SCREEN_WIDTH-[label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName, nil]].width-17, label.frame.origin.y, [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName, nil]].width, label.frame.size.height); \
} while (0)

#endif /* GlobalVarAndFunc_h */
