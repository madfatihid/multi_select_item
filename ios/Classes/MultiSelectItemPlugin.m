#import "MultiSelectItemPlugin.h"
#if __has_include(<multi_select_item/multi_select_item-Swift.h>)
#import <multi_select_item/multi_select_item-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "multi_select_item-Swift.h"
#endif

@implementation MultiSelectItemPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMultiSelectItemPlugin registerWithRegistrar:registrar];
}
@end
