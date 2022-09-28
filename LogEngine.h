//
//  LogEngine.h
//  AggregateOperationsPlayground
//
//  Created by Xcode Developer on 9/28/22.
//

#ifndef LogEngine_h
#define LogEngine_h

typedef typeof(NSAttributedString *) LogEntry;
typedef typeof(NSMutableAttributedString *) LogEntryComposition;
typedef const typeof(LogEntryComposition * restrict) LogEntryCompositionPtr;
LogEntryComposition (^log_entry_composition)(LogEntryCompositionPtr, LogEntry) = ^ (LogEntryCompositionPtr entry_composition, LogEntry entry) {
    return ^ LogEntryCompositionPtr (LogEntry log_entry) {
        return object_blk_a() && object_blk_b();
    };
};

// To-Dp: Chain LogEntry(ies) together to compose a single ehtry for the text view


static LogEntryComposition (^(^log_engine)(UITextView *))(LogEntry) = ^ (UITextView * text_view_ptr) {
    __block LogEntryComposition entry_composition = [[NSMutableAttributedString alloc] init];
    static LogEntryCompositionPtr entry_composition_t = &entry_composition;
    return ^ (LogEntry entry) {
        [*entry_composition_t appendAttributedString:entry];
        return ^ LogEntryComposition {
            return (*entry_composition_t);
        };
    };
};

#endif /* LogEngine_h */
