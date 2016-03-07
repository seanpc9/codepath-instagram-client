//
//  PostViewController.swift
//  InstaParse
//
//  Created by Sean Crenshaw on 3/6/16.
//  Copyright © 2016 Sean Crenshaw. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    var imageToUpload: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // Do something with the images (based on your use case)
            postImage.image = editedImage
            imageToUpload = resize(editedImage, newSize: CGSize(width: editedImage.size.width/2, height: editedImage.size.height/2))
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onCamera(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func onLibrary(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    static let userDidUploadNotification = "userDidUpload"
    
    @IBAction func onUpload(sender: AnyObject) {
        if imageToUpload != nil {
            Post.postUserImage(imageToUpload, withCaption: captionTextField.text, withCompletion: { (success, error) -> Void in
                if success == true {
                    print("successful upload")
                    NSNotificationCenter.defaultCenter().postNotificationName(PostViewController.userDidUploadNotification, object: nil)
                } else {
                    print(error?.localizedDescription)
                }
            })
        }
        self.performSegueWithIdentifier("postSegue", sender: nil)
    }
}