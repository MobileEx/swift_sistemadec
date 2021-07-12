//
//  takepictureVC.swift
//  sistemadecompra
//
//  Created by Richard Gomez on 4/18/18.
//  Copyright © 2018 cajunsniper. All rights reserved.
//


import UIKit
import AVFoundation
import MobileCoreServices


extension UIImage {
    
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImageOrientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        } else {
            return self
        }
    }
}

let cameraButtonBottomMargin = CGFloat(16)

class TakePicture: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let shared = TakePicture()
    
    
    var mainFrame : CGRect!
    
    var guideRectangle = CGRect(x: 0, y: 0, width: 440, height: 260)
    

   // var button : UIButton!
    
    lazy var imagePicker : UIImagePickerController = {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing = false
        imagePicker.showsCameraControls = true
        
        let side = CGFloat(UIDevice.current.userInterfaceIdiom == .pad ? 100 : 50)
        
        /*
        self.button = UIButton( frame: CGRect(x: 0, y: 0, width: side, height: side) )
        self.button.addTarget(self, action: #selector(cameraTakePicture), for: .touchUpInside)
        
        self.button.tintColor = .white
        self.button.setTitle("Take Picture", for: .normal)
        //self.button.setImage( UIImage(named: "cameraclick900")?.withRenderingMode(.alwaysTemplate), for: .normal)
     
    self.button.clipsToBounds = true
        */
        
        let overlay = UIView()
  //      overlay.addSubview(self.button)
       imagePicker.cameraOverlayView = overlay
        
     //   overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    //    overlay.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
      //  overlay.translatesAutoresizingMaskIntoConstraints = true
        
       // overlay.frame = CGRect(x: 0, y: 0, width: 20    0, height: 100)
        overlay.layer.borderColor = UIColor.orange.cgColor
        overlay.layer.borderWidth = 2.0
       // overlay.layer.cornerRadius = 3.0
        
 /*
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.centerXAnchor.constraint(equalTo: self.button.superview!.centerXAnchor).isActive = true
        self.button.bottomAnchor.constraint(equalTo: self.button.superview!.bottomAnchor, constant: -cameraButtonBottomMargin).isActive = true
        self.button.widthAnchor.constraint(equalToConstant: side).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: side).isActive = true
        */
        return imagePicker
    }()
    
    
    var completion : ((UIImage?) -> ())!
    
    /*
    @IBAction func cameraTakePicture ( _ sender : AnyObject? ) {
        imagePicker.takePicture()
    }
    */
    //MARK: - DELEGATE
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.completion( nil )
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            let factor = image.size.width / mainFrame.size.width
            
            let cropFrame = CGRect(x: guideRectangle.origin.x * factor,
                                   y: guideRectangle.origin.y * factor,
                                   width: guideRectangle.size.width * factor,
                                   height: guideRectangle.size.height * factor)
            
            print("Cropframe", cropFrame)
            
            picker.dismiss(animated: true) {
                self.completion( self.cropToRect(image: image.fixOrientation(), rect: cropFrame) )
            }
        }
    }
    
    
    func cropToRect(image: UIImage, rect: CGRect!) -> UIImage? {
        if let image = image.cgImage {
        let imageRef = image.cropping(to: rect)
        // Gets an UIImage from the CGImage
            if let ref = imageRef  {
                return UIImage.init(cgImage: ref)
            }
        }
        return nil
    }
 
    
    func takePicture( sourceViewController: UIViewController!, completion: @escaping (UIImage?) -> () ) {
        
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) else { return }
        
        self.completion = completion
        
        mainFrame = sourceViewController.view.bounds
        
        guideRectangle = CGRect(x: (mainFrame.size.width-guideRectangle.size.width)/2,
                                y: (mainFrame.size.height-guideRectangle.size.height)/2,
                                width: guideRectangle.size.width,
                                height: guideRectangle.size.height)
        
        imagePicker.cameraOverlayView!.frame = guideRectangle
        
        sourceViewController.present(imagePicker, animated: true, completion: nil)
        
        imagePicker.takePicture()
        
}
}
