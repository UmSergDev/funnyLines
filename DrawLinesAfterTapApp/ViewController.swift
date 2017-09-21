//
//  ViewController.swift
//  DrawLinesAfterTapApp
//
//  Created by Sergey Umarov on 26.02.17.
//  Copyright © 2017 Sergey Umarov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tapGestureRecognizer: UITapGestureRecognizer!
    var firstPoint: CGPoint?
    var secondPoint: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tap gestures init
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.showMoreActions(touch:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //action method after tap
    func showMoreActions(touch: UITapGestureRecognizer) {
        //instance variables
        let frameRect = self.view.frame
        let height = frameRect.height
        let width = frameRect.width
        let touchPoint = touch.location(in: self.view)
        var ctmYpos:CGFloat
        var ctmXpos:CGFloat
        var tga:CGFloat
        
        //find line coordinates from center throw touch point
        if (touchPoint.x) < (width/2){
            tga = (height/2-touchPoint.y)/(width/2 - touchPoint.x)
            ctmYpos = (height/2)-(width/2 * tga)
            ctmXpos = 0
            if ctmYpos < 0{
                ctmXpos = (-(ctmYpos)*(width/2))/(height/2-(ctmYpos))
                ctmYpos = 0
            }else if ctmYpos > height{
                ctmXpos = width - (-(ctmYpos)*(width/2))/(height/2-(ctmYpos))
                ctmYpos = height
            }
        }else{
            tga = (height/2-touchPoint.y)/(touchPoint.x-width/2)
            ctmYpos = (height/2)-((width-width/2)*tga)
            ctmXpos = width
            if ctmYpos < 0{
                ctmXpos = width - (-(ctmYpos)*(width/2))/(height/2-(ctmYpos))
                ctmYpos = 0
            } else if ctmYpos > height{
                ctmXpos = (-(ctmYpos)*(width/2))/(height/2-(ctmYpos))
                ctmYpos = height
            }
        }
        let finalPoint = CGPoint(x:ctmXpos, y:ctmYpos)
        
        //find coordinates for difeernt type of lines method
        func calcFinalPoint(cgpoint:CGPoint, num:Int)->(start:CGPoint, end:CGPoint){
            var finalSecondPt:CGPoint?
            if num == 1 {
                if(cgpoint.x < width/2)&&(cgpoint.y == 0){finalSecondPt = CGPoint(x:0, y:(cgpoint.x*(width/2-cgpoint.x))/(height/2))}
                if(cgpoint.x > width/2)&&(cgpoint.y == 0){finalSecondPt = CGPoint(x:width, y:(cgpoint.x-width/2)*(width-cgpoint.x)/(height/2))}
                if(cgpoint.x == width)&&(cgpoint.y < height/2){finalSecondPt = CGPoint(x:width-(cgpoint.y*tga), y:0)}
                if(cgpoint.x == width)&&(cgpoint.y > height/2){finalSecondPt = CGPoint(x:width-(height-cgpoint.y)*(-tga), y:height)}
                if(cgpoint.x > width/2)&&(cgpoint.y == height){finalSecondPt = CGPoint(x:width, y:height - (cgpoint.x-width/2)*(width-cgpoint.x)/(height/2))}
                if(cgpoint.x < width/2)&&(cgpoint.y == height){finalSecondPt = CGPoint(x:0, y:height-(cgpoint.x*(width/2-cgpoint.x))/(height/2))}
                if(cgpoint.x == 0)&&(cgpoint.y > height/2){finalSecondPt = CGPoint(x:(height-cgpoint.y)*(-tga), y:height)}
                if(cgpoint.x == 0)&&(cgpoint.y < height/2){finalSecondPt = CGPoint(x:cgpoint.y*tga, y:0)}
            }else if (num == 2){
                if(cgpoint.x < width/2)&&(cgpoint.y == 0){finalSecondPt = CGPoint(x:width, y:cgpoint.x*(width-cgpoint.x)/(secondPoint?.y)!)}
                if(cgpoint.x > width/2)&&(cgpoint.y == 0){finalSecondPt = CGPoint(x:0, y:cgpoint.x*(width-cgpoint.x)/(secondPoint?.y)!)}
                if(cgpoint.x == width)&&(cgpoint.y < height/2){finalSecondPt = CGPoint(x:width-cgpoint.y*(height-cgpoint.y)/(width-(secondPoint?.x)!), y:height)}
                if(cgpoint.x == width)&&(cgpoint.y > height/2){finalSecondPt = CGPoint(x:width-cgpoint.y*(height-cgpoint.y)/(width-(secondPoint?.x)!), y:0)}
                if(cgpoint.x > width/2)&&(cgpoint.y == height){finalSecondPt = CGPoint(x:0, y:height-cgpoint.x*(width-cgpoint.x)/(height-(secondPoint?.y)!))}
                if(cgpoint.x < width/2)&&(cgpoint.y == height){finalSecondPt = CGPoint(x:width, y:height-cgpoint.x*(width-cgpoint.x)/(height-(secondPoint?.y)!))}
                if(cgpoint.x == 0)&&(cgpoint.y > height/2){finalSecondPt = CGPoint(x:cgpoint.y*(height-cgpoint.y)/((secondPoint?.x)!), y:0)}
                if(cgpoint.x == 0)&&(cgpoint.y < height/2){finalSecondPt = CGPoint(x:cgpoint.y*(height-cgpoint.y)/(secondPoint?.x)!, y:height)}
            }else if (num == 3){
                if(cgpoint.x <= width)&&(cgpoint.y == 0)&&(touchPoint.x<width/2){finalSecondPt = CGPoint(x:width, y:cgpoint.x*(width-cgpoint.x)/(secondPoint?.y)!)}
                if(cgpoint.x <= width)&&(cgpoint.y == 0)&&(touchPoint.x>width/2){finalSecondPt = CGPoint(x:0, y:cgpoint.x*(width-cgpoint.x)/(secondPoint?.y)!)}
                if(cgpoint.x == width)&&(cgpoint.y <= height)&&(touchPoint.y<height/2){finalSecondPt = CGPoint(x:width-cgpoint.y*(height-cgpoint.y)/(width-(secondPoint?.x)!), y:height)}
                if(cgpoint.x == width)&&(cgpoint.y <= height)&&(touchPoint.y>height/2){finalSecondPt = CGPoint(x:width-cgpoint.y*(height-cgpoint.y)/(width-(secondPoint?.x)!), y:0)}
                if(cgpoint.x <= width)&&(cgpoint.y == height)&&(touchPoint.x<width/2){finalSecondPt = CGPoint(x:width, y:height-cgpoint.x*(width-cgpoint.x)/(height-(secondPoint?.y)!))}
                if(cgpoint.x <= width)&&(cgpoint.y == height)&&(touchPoint.x>width/2){finalSecondPt = CGPoint(x:0, y:height-cgpoint.x*(width-cgpoint.x)/(height-(secondPoint?.y)!))}
                if(cgpoint.x == 0)&&(cgpoint.y <= height)&&(touchPoint.y>height/2){finalSecondPt = CGPoint(x:cgpoint.y*(height-cgpoint.y)/((secondPoint?.x)!), y:0)}
                if(cgpoint.x == 0)&&(cgpoint.y <= height)&&(touchPoint.y<height/2){finalSecondPt = CGPoint(x:cgpoint.y*(height-cgpoint.y)/(secondPoint?.x)!, y:height)}
            }
            
            return(cgpoint, finalSecondPt!)
        }
        //get values for instances
        firstPoint = self.view.center
        secondPoint = finalPoint
        
        //draw lines
        self.view.layer.sublayers?.removeLast((self.view.layer.sublayers?.count)!-2)
        addLine(fromPoint: firstPoint!, toPoint: secondPoint!)
        let points = calcFinalPoint(cgpoint: finalPoint, num:1)
        addLine(fromPoint: points.start, toPoint: points.end)
        let newpoints1 = calcFinalPoint(cgpoint: points.end, num:2)
        addLine(fromPoint: newpoints1.start, toPoint: newpoints1.end)
        secondPoint = newpoints1.start
        let newpoints2 = calcFinalPoint(cgpoint: newpoints1.end, num:3)
        addLine(fromPoint: newpoints2.start, toPoint: newpoints2.end)
        
        
    }
    //random color for lines method
    func randomColor() -> UIColor {
        let hue:CGFloat = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        return UIColor(hue: hue, saturation: 0.8, brightness: 1.0, alpha: 0.8)
    }
    
    //draw line method
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = randomColor().cgColor
        line.lineWidth = 1
        line.lineJoin = kCALineJoinRound
        self.view.layer.addSublayer(line)
        
    }
    
}

