//
//  PhotoViewController.swift
//  Code_For_Good
//
//  Created by Nicholas Miller on 2/5/16.
//  Copyright © 2016 team3. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if (!UIImagePickerController.isSourceTypeAvailable(.Camera)){
            cameraButton.enabled = false
        }
        
        if (myImageView.image == nil) {
            cancelButton.hidden = true
            acceptButton.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTouched(sender: AnyObject) {
        myImageView.image = nil
        cancelButton.hidden = true
        acceptButton.hidden = true
    }
    
    @IBAction func cameraButtonTouched(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func albumButtonPicked(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageView.contentMode = .ScaleToFill
            myImageView.image = pickedImage
            
            print(pickedImage)
        }
        
        cancelButton.hidden = false
        acceptButton.hidden = false
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if segue.identifier == "PhotoToInfo" {
    //            let infoViewController = segue.destinationViewController as! InfoViewController
    //            print(myImageView.image)
    //            infoViewController.myImageView.image = myImageView.image
    //        }
    //    }
    
}
