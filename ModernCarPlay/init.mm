//
//  init.mm
//  ModernCarPlay
//
//  Created by Jinwoo Kim on 5/17/25.
//

#import <Foundation/Foundation.h>
#include <objc/runtime.h>
#include <objc/message.h>

namespace mc_DBDashboardLayoutEngine {
    namespace hasEmbeddedSecondaryContentArea {
        BOOL custom(id self, SEL _cmd) {
            return YES;
        }
        void swizzle(void) {
            Method method = class_getInstanceMethod(objc_lookUpClass("DBDashboardLayoutEngine"), sel_registerName("hasEmbeddedSecondaryContentArea"));
            assert(method != NULL);
            method_setImplementation(method, reinterpret_cast<IMP>(custom));
        }
    }
}

namespace mc_DBEnvironmentConfiguration {
    namespace hasDualStatusBar {
        BOOL custom(id self, SEL _cmd) {
            return YES;
        }
        void swizzle(void) {
            Method method = class_getInstanceMethod(objc_lookUpClass("DBEnvironmentConfiguration"), sel_registerName("hasDualStatusBar"));
            assert(method != NULL);
            method_setImplementation(method, reinterpret_cast<IMP>(custom));
        }
    }
}

namespace mc_DBDashboardHomeViewController {
    namespace _shouldHideTodayView {
        BOOL custom(id self, SEL _cmd) {
            return NO;
        }
        void swizzle(void) {
            Method method = class_getInstanceMethod(objc_lookUpClass("DBDashboardHomeViewController"), sel_registerName("_shouldHideTodayView"));
            assert(method != NULL);
            method_setImplementation(method, reinterpret_cast<IMP>(custom));
        }
    }
}

__attribute__((constructor)) static void init() {
#if DEBUG
    if (static_cast<NSNumber *>(NSProcessInfo.processInfo.environment[@"MC_WAIT_FOR_DEBUGGER"]).boolValue) {
        kill(getpid(), SIGSTOP);
    }
#endif
    
    mc_DBDashboardLayoutEngine::hasEmbeddedSecondaryContentArea::swizzle();
    mc_DBEnvironmentConfiguration::hasDualStatusBar::swizzle();
    mc_DBDashboardHomeViewController::_shouldHideTodayView::swizzle();
}
