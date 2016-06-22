//
//  ExtendUITextField.swift
//  SuppliersTest
//
//  Created by Duo Li An on 6/19/16.
//  Copyright © 2016 Duo Li An. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    var stringValue : String { return text                ?? "" }
    var integerValue: Int    { return Int(stringValue)    ?? 0  }
    var doubleValue : Double { return Double(stringValue) ?? 0  }
    var floatValue  : Float  { return Float(stringValue)  ?? 0  }
}