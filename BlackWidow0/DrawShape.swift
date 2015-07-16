//
//  DrawShape.swift
//  BlackWidow0
//
//  Created by Kathryn Reagan on 7/9/15.
//  Copyright (c) 2015 Emerson Process Management. All rights reserved.
//

import Foundation
import UIKit


class DrawShape : UIView {
    
    let shape: GraphicItem
    //
    //    override init(frame: CGRect) {
    //        shape = nil
    //        super.init(frame: frame)
    //    }
    //
    required init(coder aDecoder: NSCoder) {
        shape = GraphicItem()
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, shape: GraphicItem) {
        self.shape = shape
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    
    override func drawRect(rect: CGRect) {
        if shape.type == "circle" {
            drawCircle(rect, cir: (shape as? Circle)!)
        }
        else if shape.type == "pie" {
            drawPie(rect, pie: (shape as? Pie)!)
        }
            
        else{
            NSLog("not a circle or pie, you suck")
        }
        
    }
    
    
    func drawCircle(rect: CGRect, cir: Circle){
     
        var bounds:CGRect = rect
        var center = CGPoint()
        center.x = bounds.origin.x + bounds.size.width / 2.0
        center.y = bounds.origin.y + bounds.size.height / 2.0
        var radius = (min(bounds.size.width, bounds.size.height) / 2.0)
        radius -= CGFloat(cir.border.thickness)
        var path:UIBezierPath = UIBezierPath()
        path.addArcWithCenter(center, radius: CGFloat(radius), startAngle: CGFloat(0.0), endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        
        // stroke and fill
        path.lineWidth = CGFloat(cir.border.thickness)
        cir.border.color.setStroke()
        path.stroke()
        cir.fill.color.setFill()
        path.fill()
        
        
    }
    
    
    func drawPie(rect: CGRect, pie: Pie){
        var bounds:CGRect = rect
        var center = CGPoint()
        center.x = bounds.origin.x + bounds.size.width / 2.0
        center.y = bounds.origin.y + bounds.size.height / 2.0
        var radius = (min(bounds.size.width, bounds.size.height) / 2.0)
        radius -= CGFloat(pie.border.thickness)
        var path:UIBezierPath = UIBezierPath()
        path.addArcWithCenter(center, radius: CGFloat(radius), startAngle: degToRad(pie.startAngle - 90 + pie.angle), endAngle: degToRad(pie.endAngle - 90 + pie.angle), clockwise: true)
        path.addLineToPoint(center)
        path.closePath()
        
        // stroke and fill
        path.lineWidth = CGFloat(pie.border.thickness)
        pie.border.color.setStroke()
        path.stroke()
        pie.fill.color.setFill()
        path.fill()
        
//        if(pie.fill.percent < 1){
//            drawFill(rect, shape: pie)
//        }
    }
    
    
    
    // can't get this to work
//    func drawFill(rect: CGRect, shape: Pie){
//        var bounds:CGRect = rect
//        var center = CGPoint()
//        center.x = bounds.origin.x + bounds.size.width / 2.0
//        center.y = bounds.origin.y + bounds.size.height / 2.0
//        var radius = (min(bounds.size.width, bounds.size.height) / 2.0)
//        radius -= CGFloat(shape.border.thickness)
//        var path:UIBezierPath = UIBezierPath()
//        var start = shape.fill.angle - 90 + shape.angle
//        var end = Double(start) - (shape.fill.percent * 360)
//        path.addArcWithCenter(center, radius: CGFloat(radius), startAngle: degToRad(start), endAngle: degToRad(end), clockwise: true)
//       // path.addLineToPoint(center)
//        
//       // path.closePath()
//    
//        // stroke and fill
//        path.lineWidth = CGFloat(shape.border.thickness)
//        shape.border.color.setStroke()
//        path.stroke()
//        shape.fill.background.setFill()
//        path.fill()
//    
//    
//    
//    }
    
    
    
    
    
    func degToRad(deg: NSNumber) -> CGFloat {
        var num = CGFloat(deg) * CGFloat(M_PI) / 180.0
        NSLog("\(deg) degrees = \(num) radians.")
        return num
    }
    
    
    
    
}