//
//  AISpeechClient.swift
//  Ting
//
//  Created by Chordia, Amisha (US - Mumbai) on 9/21/15.
//  Copyright © 2015 Chordia, Amisha (US - Mumbai). All rights reserved.
//

import UIKit

class AISpeechClient: NSObject {
    
   static func readCurrentString(str : String) {
    let synth = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: str)
        utterance.rate = 0.55
        do {
            try  AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        }
        catch{
        }
        synth.speakUtterance(utterance)
    }
}
