//
//  UpdateViewController.swift
//  Zade
//
//  Created by Parth Bhojak on 15/07/19.
//  Copyright © 2019 Parth Bhojak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


class UpdateViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
      let db = Firestore.firestore()
     var documentid = ""
    
    @IBOutlet weak var addPostData: UITextView!
    
    
    @IBOutlet weak var uploadImage: UIButton!
    
    
    @IBOutlet weak var selectUpload: UIImageView!
    
    @IBOutlet weak var uploadPostbutton: UIButton!
    
    
    var postdata : String =  ""
    var uploadImages : String = ""
    var imageName : String = ""
    var uid :String = ""
    var likes : UIButton?
    var userimage = UIImage.self
    //     var postId = ""
    
  
    var selectedImage: UIImage?
    
//        let userID = Auth.auth().currentUser!.uid
//    var id = Auth.auth().currentUser?.displayName

    
    let imagepicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        
      
        super.viewDidLoad()
     let db = Firestore.firestore()
        addPostData.text = "Enter Text Here"
        addPostData.textColor = UIColor.lightGray
        addPostData.layer.borderWidth = 1
        
        getCurrentUser()
}
    
    func getCurrentUser(){
        let user = Auth.auth().currentUser
        if let user = user {
            uid = user.uid
            
        }
    }
 
    @IBAction func sharePost(_ sender: UIButton) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true
        
        var ref: DocumentReference? = nil
        
        guard let userimages = Auth.auth().currentUser!.photoURL
        else
       {
            return
        }
           print(userimages)
        guard let usernames = Auth.auth().currentUser!.displayName
        else
        {
            return
        }
        print(usernames)
        
         print(Auth.auth().currentUser!.photoURL!)
        ref = db.collection("posts").addDocument(data:["postdata":"\(addPostData.text!)", "uid": uid,"Like": likes as Any,"Date" : FieldValue.serverTimestamp(),"UserImage":"\(userimages)","UserNames": "\(usernames)"]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                self.documentid = (ref?.documentID)!
                print("Document added with ID: \(ref!.documentID)")
                let uploadRef = Storage.storage().reference(withPath: "Images/\(self.documentid).jpg")
                
                guard let imagedata = self.selectUpload.image?.jpegData(compressionQuality: 0.75) else{return}
                let uploadMetadata = StorageMetadata.init()
          
                uploadMetadata.contentType = "image/jpeg"
                uploadRef.putData(imagedata, metadata: uploadMetadata) { (downloadMetadata, error) in
                    if let error = error
                    {
                        print("oh no got an error \(error.localizedDescription)")
                        return
                    }
                    print("put is complete and i got it back:\(String(describing: downloadMetadata))")
                    
                }
            }
        }
     
        
        addPostData.text = " "
        
    }


    @IBAction func UploadImagePressed(_ sender: UIButton) {
        
        
        imagepicker.allowsEditing = false
        imagepicker.sourceType = .photoLibrary
        imagepicker.delegate = self
        imagepicker.mediaTypes = ["public.image", "public.movie"]
        present(imagepicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        if let editedImage = info[.editedImage] as? UIImage {
            
            selectedImage = editedImage
            
            selectUpload.image = selectedImage!
            
            picker.dismiss(animated: true, completion: nil)
            print(selectUpload)
            
        } else if let originalImage = info[.originalImage] as? UIImage {
            
            selectedImage = originalImage
            
            selectUpload.image = selectedImage!
            
        }
        
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        
        print(fileUrl.lastPathComponent)
        
        imageName = fileUrl.lastPathComponent
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addPostPressed(_ sender: UIButton) {
        
        
        
    }
    
    
}
