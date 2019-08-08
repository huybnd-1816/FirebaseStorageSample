//
//  MainViewModel.swift
//  FirebaseStorageSample
//
//  Created by nguyen.duc.huyb on 7/30/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import Firebase

final class MainViewModel: NSObject {
    private var audioList: [Audio] = [] {
        didSet {
            didChanged?(.success)
        }
    }
    
    var didChanged: ((BaseResult) -> Void)?
    
    override init() {
        super.init()
        reloadData()
    }
    
    private func reloadData() {
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        do {
            let audioPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for audio in audioPath {
                var myAudio = audio.absoluteString // Get song's url
                if myAudio.contains(".wav") {
                    let findString = myAudio.components(separatedBy: "/") // Separate string has "/" into an array
                    myAudio = findString[findString.count - 1] // Get the original song
                    myAudio = myAudio.replacingOccurrences(of: "%20", with: " ")
                    myAudio = myAudio.replacingOccurrences(of: ".wav", with: "")
                    
                    let item = Audio(audioName: myAudio, audioUrl: audio)
                    audioList.append(item)
                }
            }
        } catch {
            didChanged?(.failure(error: error))
        }
    }
}

extension MainViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MainViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audioList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AudioCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configAudioCell(audioList[indexPath.row])
        cell.didUploadAudio = { [weak self] in
            guard let self = self else { return }
            FirebaseService.shared.uploadFile(self.audioList[indexPath.row])
        }
        
        cell.didDeleteAudio = { [weak self] in
            guard let self = self else { return }
            FirebaseService.shared.deleteFile(self.audioList[indexPath.row])
        }
        return cell
    }
}
