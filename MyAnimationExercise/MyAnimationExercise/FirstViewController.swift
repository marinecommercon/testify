//
//  FirstViewController.swift
//  MyAnimationExercise
//
//  Created by Technique on 18/06/2016.
//  Copyright © 2016 Marine Commerçon. All rights reserved.
//

import UIKit

extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContextRef
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        tintColor.setFill()
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}



class FirstViewController: UIViewController {

    var tabBar: UITabBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customPinkColor = UIColor(red: 295/255, green: 97/255, blue: 160/255, alpha: 1)
        let customGrayColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1)
        
        tabBar = self.tabBarController!.tabBar
        tabBar!.tintColor = customPinkColor
        
        let image = UIImage(named: "tab_back")
        tabBar!.backgroundImage = ResizeImage(image!, targetSize: tabBar!.frame.size)

        
        // To change tintColor for unselect tabs
        for item in tabBar!.items! as [UITabBarItem] {
            if let image = item.image {
                item.image = image.imageWithColor(customGrayColor).imageWithRenderingMode(.AlwaysOriginal)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        // Rect is a frame with the size of tab bar
        let rect = CGRectMake(0, 0, targetSize.width, targetSize.height)
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        
        // We draw the image in rect
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

}

