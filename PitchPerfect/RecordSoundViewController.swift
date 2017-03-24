//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Amarnath Manipatra on 14/11/16.
//  Copyright © 2016 otd. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController , AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
       func requestRecordPermission(_ response: @escaping PermissionBlock)
       {
        
        }
        
        stopButton.isEnabled = false;
     
        
    }

    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!

    @IBOutlet weak var stopButton: UIButton!

    
    
    
   
    @IBAction func recordBtn(_ sender: Any) {
        recordLabel.text = "recording in progress";
        stopButton.isEnabled = true;
        recordButton.isEnabled=false;
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
       
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
  
    @IBAction func stopBtn(_ sender: Any) {
        recordLabel.text = "tap to record";
        stopButton.isEnabled = false;
        recordButton.isEnabled=true;
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setActive(false)
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag)
        {
        self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else
        {
            print("Problem Recording")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

