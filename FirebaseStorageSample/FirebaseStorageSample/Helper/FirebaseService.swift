//
//  FirebaseService.swift
//  FirebaseStorageSample
//
//  Created by nguyen.duc.huyb on 8/8/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import Firebase

final class FirebaseService {
    static let shared = FirebaseService()
    
    private var uploadTask: StorageUploadTask!
    private var storageRef: StorageReference!
    var didShowPercentage: ((Double) -> Void)?
    var didUploadCompleted: (() -> Void)?
    
    private init() {
        // Get a reference to the storage service using the default Firebase App
        // Create a storage reference from our storage service
        storageRef = Storage.storage().reference()
    }
    
    deinit {
        // Remove all observers
        if uploadTask != nil {
            uploadTask.removeAllObservers()
        }
    }
    
    func uploadFile(_ audio: Audio) {
        guard let audioName = audio.audioName else { return }
        
        // Points to "images"
        let audiosRef = storageRef.child("audios/" + audioName)
        
        // Local file you want to upload
        guard let localFile = audio.audioUrl else { return }
        
        // Create the file metadata
        let metadata = StorageMetadata()
        metadata.contentType = "audio/wav"
        
        // Upload file and metadata to the object 'images/mountains.jpg'
        uploadTask = audiosRef.putFile(from: localFile, metadata: metadata)
        
        // UploadTask Inprogress
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentComplete = Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            print("PercentComplete: ", percentComplete)
            self.didShowPercentage?(percentComplete)
        }
        
        // UploadTask Success
        uploadTask.observe(.success) { snapshot in
            IHProgressHUD.showSuccesswithStatus("Upload successful")
            print("Uploading is complete")
            self.didUploadCompleted?()
        }
        
        //UploadTask Failure
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                var err: String!
                
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    err = BaseError.objectNotFound.errorMessage
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    err = BaseError.unauthorized.errorMessage
                    break
                case .cancelled:
                    // User canceled the upload
                    err = BaseError.cancelled.errorMessage
                    break
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    err = BaseError.unknown.errorMessage
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    err = BaseError.defaultErr.errorMessage
                    break
                }
                IHProgressHUD.showError(withStatus: err)
            }
        }
    }
    
    func deleteFile(_ audio: Audio) {
        guard let audioName = audio.audioName else { return }
        
        // Points to "images"
        let audiosRef = storageRef.child("audios/" + audioName)
        
        // Delete the file
        audiosRef.delete { error in
            if let error = error {
                IHProgressHUD.showError(withStatus: error.localizedDescription)
            } else {
                // File deleted successfully
                IHProgressHUD.showSuccesswithStatus("Delete successful")
            }
        }
        
    }
}
