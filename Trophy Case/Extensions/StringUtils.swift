//
//  UIColorExtensions.swift
//  UIKit Enhancements
//
//  Created by Jason Slater on 2016-12-28.
//  Copyright © 2016 Jason Slater. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Colours
// Regex to test if a string is a valid colour, using either a 0x or a # prefix

public extension String {
	
	func isRGB () -> Bool {
		guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: "\\A(0x|#)[a-f0-9]{6}\\Z", options: .caseInsensitive) else {
			return false
		}
		
		return (regex.matches(in: self, options: .anchored, range: NSMakeRange(0, count)).count > 0)
	}
	
	func isARGB () -> Bool {
		guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: "\\A(0x|#)[a-f0-9]{8}\\Z", options: .caseInsensitive) else {
			return false
		}
		
		return (regex.matches(in: self, options: .anchored, range: NSMakeRange(0, count)).count > 0)
	}
	
	func isRGB (orARGB: Bool) -> Bool {
		if (orARGB) {
			guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: "\\A(0x|#)[a-f0-9]{6}(?:[a-f0-9]{2})?\\Z", options: .caseInsensitive) else {
				return false
			}
			
			return (regex.matches(in: self, options: .anchored, range: NSMakeRange(0, count)).count > 0)
		}
		
		return isRGB()
	}
	
}


// MARK: - Localisation
// Convenience function to quicky localise strings. ex: "MyString".localised()

public extension String {
	nonmutating func localised(withComment comment: String = "", bundle: Bundle = Bundle.main) -> String {
		return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: comment)
	}
}
