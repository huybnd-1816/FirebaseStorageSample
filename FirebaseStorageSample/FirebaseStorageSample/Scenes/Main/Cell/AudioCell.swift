//
//  AudioCell.swift
//  FirebaseStorageSample
//
//  Created by nguyen.duc.huyb on 7/30/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


final class AudioCell: UITableViewCell, NibReusable {
    @IBOutlet weak var audioNameLabel: UILabel!
    
    var didUploadAudio: (() -> Void)?
    var didDeleteAudio: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configAudioCell(_ audio: Audio) {
        audioNameLabel.text = audio.audioName
    }
    
    @IBAction func handleUploadButtonTapped(_ sender: Any) {
        didUploadAudio?()
    }
    
    @IBAction func handleDeleteButtonTapped(_ sender: Any) {
        didDeleteAudio?()
    }
}
