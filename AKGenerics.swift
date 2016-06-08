//
//  AKGenerics.swift
//  AKGenerics
//
//  Created by Ken M. Haggerty on 1/8/16.
//  Copyright © 2016 Ken M. Haggerty. All rights reserved.
//

import Dispatch

// Via Stack Overflow: http://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language
//extension String {
//    
//    subscript (i: Int) -> Character {
//        return self[self.startIndex.advancedBy(i)]
//    }
//    
//    subscript (i: Int) -> String {
//        return String(self[i] as Character)
//    }
//    
//    subscript (r: Range<Int>) -> String {
//        let start = startIndex.advancedBy(r.startIndex)
//        let end = start.advancedBy(r.endIndex - r.startIndex)
//        return self[Range(start ..< end)]
//    }
//}

//public extension NSObject {
//    public class var class: String{
//        return NSStringFromClass(self).componentsSeparatedByString(".").last!
//    }
//    
//    public var nameOfClass: String{
//        return NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!
//    }
//}

extension UIScrollView {
    
    func scrollToView(view: UIView, withPadding padding: CGSize, animated: Bool) {
        let center = view.center
        let size = CGSizeMake(view.frame.width+padding.width*2, view.frame.height+padding.height*2)
        let rect = CGRectMake(center.x-size.width*0.5, center.y-size.height*0.5, size.width, size.height)
        self.scrollRectToVisible(rect, animated: true)
    }
}

extension UIView
{
    class func initFromNib() -> Self
    {
        return instantiateFromNib()
    }
    
    private class func instantiateFromNib<T>() -> T
    {
        let nib = UINib(nibName: String(self), bundle: nil)
        let view = nib.instantiateWithOwner(nil, options: nil)[0] as! T
        return view
    }
}

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
