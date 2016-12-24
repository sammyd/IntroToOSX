/*
 * Copyright (c) 2015 Razeware LLC
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Cocoa

class CodeStringFormattingTransformer: ValueTransformer {
  
  let name =  NSValueTransformerName("CodeStringFormattingTransformer")
  
  override class func transformedValueClass() -> AnyClass {
    return NSAttributedString.self
  }
  
  override class func allowsReverseTransformation() -> Bool {
    return false
  }
  
  override func transformedValue(_ value: Any?) -> Any? {
    if let s = value as? String {
      let unescaped = s.replacingOccurrences(of: "\\/", with: "/")
        .replacingOccurrences(of: "\\r", with: "")
        .replacingOccurrences(of: "\\n", with: "\n")
      
      let font = NSFont(name: "Menlo", size: 11.0)!
      let attributes = [ NSFontAttributeName : font ]
      return NSAttributedString(string: unescaped, attributes: attributes)
    }
    return nil
  }
}
