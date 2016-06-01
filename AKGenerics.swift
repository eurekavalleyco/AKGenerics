//
//  AKGenerics.swift
//  AKGenerics
//
//  Created by Ken M. Haggerty on 1/8/16.
//  Copyright © 2016 Ken M. Haggerty. All rights reserved.
//

import Dispatch

func optionalOr(whereNil boolForNil: Bool, args: Bool?...) -> Bool! {
    for arg: Bool? in args {
        if (arg == nil) {
            if (boolForNil) {
                return true
            }
        }
        else if (arg!) {
            return true
        }
    }
    
    return false
}

func optionalAnd(whereNil boolForNil: Bool, args: Bool?...) -> Bool! {
    for arg: Bool? in args {
        if (arg == nil) {
            if (!boolForNil) {
                return false
            }
        }
        else if (!arg!) {
            return false
        }
    }
    
    return true
}

func nonNil(args: AnyObject?...) -> AnyObject? {
    for arg: AnyObject? in args {
        if (arg != nil) {
            return arg
        }
    }
    
    return nil;
}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
