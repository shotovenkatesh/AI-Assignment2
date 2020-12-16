//
//  ViewController.swift
//  AI Assignment 2
//
//  Created by Venkatesh on 17/12/2020.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    //MARK: -Section1
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imagePicker.delegate = self
    imagePicker.isEditing = false
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }else{
            imagePicker.sourceType = .photoLibrary
        }
    }
   //MARK: -Section2
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            fatalError("Unable to convert to UI Image")
        }
        //MARK: -Section 2.1
        imageView.image = userImage
        guard  let ciImage = CIImage(image: userImage) else{
            fatalError("Error converting UIImage to a CIImage")
        }
        mlWork(image: ciImage)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    //MARK: -Section4
    func mlWork(image: CIImage){
        guard   let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Unable to fetch model")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let result = request.results as? [VNClassificationObservation] else{
                fatalError("Failed to get results")
            }
            //MARK: -Section6
            if  let firstResult = result.first{
               if firstResult.identifier.contains("pizza"){
                self.navigationController?.navigationBar.barTintColor = UIColor.green
                self.navigationItem.title = "Pizza!"
               }else{
                self.navigationController?.navigationBar.barTintColor = UIColor.red
                self.navigationItem.title = "Not a Pizza"
                }
            }
        }
        //MARK: -Section5
        let handler = VNImageRequestHandler(ciImage : image)
        do{
            try handler.perform([request])
        }catch{
            print("Unable to perform request")
        }
    }
    
    
    //MARK: -Section3
    
    @IBAction func CameraClicked(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}


