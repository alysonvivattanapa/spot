//
//  TBARLabelView.swift
//  dgtlMap
//
//  Created by Alyson Vivattanapa on 10/21/17.
//  Copyright © 2017 Alyson Vivattanapa. All rights reserved.
//

import UIKit


class TBARLabelView: UIView {
    convenience init(_ frame: CGRect, text: String) {
        self.init(frame: frame)
        let padding = CGFloat(6)
        let label = UILabel.init(frame: CGRect(x: padding,
                                               y: padding,
                                               width: frame.size.width - padding*2,
                                               height: frame.size.height - padding*2))
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.text = text;
        label.textColor = UIColor.white
        self.addSubview(label)
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
    }
    
    public func imageForView() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
