//
//  ViewController.swift
//  NemoCam
//
//  Created by Simon Gladman on 09/04/2016.
//  Copyright © 2016 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CameraCaptureHelperDelegate
{
    var time: CGFloat = 0
    
    let imageView = OpenGLImageView()
    let cameraCaptureHelper = CameraCaptureHelper(cameraPosition: .Back)
    
    let causticRefraction: CausticRefraction =
    {
        let filter = CausticRefraction()
        
        filter.inputSoftening = 5
        filter.inputRefractiveIndex = -8
        filter.inputLensScale = 65
        
        return filter
    }()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        
        cameraCaptureHelper.delegate = self
    }
    
    override func viewDidLayoutSubviews()
    {
        imageView.frame = view.bounds
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    
    func newCameraImage(cameraCaptureHelper: CameraCaptureHelper, image: CIImage)
    {
        causticRefraction.inputImage = image
        causticRefraction.inputTime = time
        
        time += 0.04
        
        imageView.image = causticRefraction.outputImage
    }
}
