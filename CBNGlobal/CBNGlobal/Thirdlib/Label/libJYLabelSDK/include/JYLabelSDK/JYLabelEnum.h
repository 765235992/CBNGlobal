
#ifndef JYLabelEnum_h
#define JYLabelEnum_h
typedef enum
{
    JYTextAlignmentRight = kCTRightTextAlignment,
    JYTextAlignmentLeft = kCTLeftTextAlignment,
    JYTextAlignmentCenter = kCTCenterTextAlignment,
    JYTextAlignmentJustify = kCTJustifiedTextAlignment
} JYTextAlignment;
typedef enum
{
    JYTextLineBreakModeWordWrapping = kCTLineBreakByWordWrapping,
    JYTextLineBreakModeCharWrapping = kCTLineBreakByCharWrapping,
    JYTextLineBreakModeClip = kCTLineBreakByClipping,
}JYTextLineBreakMode;

#endif /* JYLabelEnum_h */
