//
//  UIColorExtension.swift
//  zaffaripoc
//
//  Created by Companhia Zaffari on 25/07/2019.
//  Copyright © 2019 Companhia Zaffari. All rights reserved.
//

extension UIColor {
    public static var zaffariColorPrimary: UIColor { return UIColor(hexString: "#388E3C")}
    public static var zaffariColorAccent: UIColor { return UIColor(hexString:"#009688")}
    public static var textColorPrimary: UIColor { return UIColor(hexString:"#212121")}
    public static var textColorSeccondary: UIColor { return UIColor(hexString:"#212121") }
    
    public convenience init(hexString: String) {
        let hexString:NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        let scanner            = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
}
