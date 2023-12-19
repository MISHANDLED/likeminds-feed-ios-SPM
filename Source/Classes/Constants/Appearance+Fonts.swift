//
//  Appearance+Fonts.swift
//  LMFramework
//
//  Created by Devansh Mohata on 07/12/23.
//

import UIKit

public extension Appearance {
    struct Fonts {
        private init() { }
        
        // Shared Instance
        public static var shared = Fonts()
        
        // Variables
        public var headingFont1: UIFont = .systemFont(ofSize: 16, weight: .medium)
        public var headingFont2: UIFont = .systemFont(ofSize: 12, weight: .medium)
        public var headingFont3: UIFont = .systemFont(ofSize: 14, weight: .medium)
        public var subHeadingFont1: UIFont = .systemFont(ofSize: 12)
        public var subHeadingFont2: UIFont = .systemFont(ofSize: 14)
        public var textFont1: UIFont = .systemFont(ofSize: 16)
        public var buttonFont: UIFont = .systemFont(ofSize: 14)
        public var navigationFont: UIFont = .systemFont(ofSize: 18, weight: .bold)
    }
}
