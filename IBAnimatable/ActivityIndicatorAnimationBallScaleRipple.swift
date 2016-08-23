//
//  Created by Tom Baranes on 23/08/16.
//  Copyright (c) 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class ActivityIndicatorAnimationBallScaleRipple: ActivityIndicatorAnimating {

  // MARK: Properties

  private let duration: CFTimeInterval = 1
  private let timingFunction = CAMediaTimingFunction(controlPoints: 0.21, 0.53, 0.56, 0.8)

  // MARK: ActivityIndicatorAnimating

  public func configAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
    let animation = self.animation
    let circle = ActivityIndicatorShape.Ring.createLayerWith(size: size, color: color)
    let frame = CGRect(x: (layer.bounds.size.width - size.width) / 2,
                       y: (layer.bounds.size.height - size.height) / 2,
                       width: size.width,
                       height: size.height)

    circle.frame = frame
    circle.addAnimation(animation, forKey: "animation")
    layer.addSublayer(circle)
  }
}

// MARK: - Setup

private extension ActivityIndicatorAnimationBallScaleRipple {

  var animation: CAAnimationGroup {
    let animation = CAAnimationGroup()
    animation.animations = [scaleAnimation, opacityAnimation]
    animation.duration = duration
    animation.repeatCount = HUGE
    animation.removedOnCompletion = false
    return animation
  }

  var scaleAnimation: CAKeyframeAnimation {
    let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    scaleAnimation.keyTimes = [0, 0.7]
    scaleAnimation.timingFunction = timingFunction
    scaleAnimation.values = [0.1, 1]
    scaleAnimation.duration = duration
    return scaleAnimation
  }

  var opacityAnimation: CAKeyframeAnimation {
    let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
    opacityAnimation.keyTimes = [0, 0.7, 1]
    opacityAnimation.timingFunctions = [timingFunction, timingFunction]
    opacityAnimation.values = [1, 0.7, 0]
    opacityAnimation.duration = duration
    return opacityAnimation
  }
  
}
