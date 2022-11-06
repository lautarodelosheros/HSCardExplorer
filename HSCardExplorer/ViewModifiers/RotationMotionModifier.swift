//
//  RotationMotionModifier.swift
//  HSCardExplorer
//
//  Created by Lautaro de los Heros on 06/11/2022.
//

import Foundation
import SwiftUI
import CoreMotion

struct RotationMotionModifier: ViewModifier {
    
    @ObservedObject var manager: MotionManager
    var multiplier: Double
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(manager.x * multiplier), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(.degrees(manager.y * multiplier), axis: (x: -1, y: 0, z: 0))
    }
}

class MotionManager: ObservableObject {

    @Published var x: Double = 0.0
    @Published var y: Double = 0.0
    
    private var manager: CMMotionManager
    
    private let pitchAdjustment = 0.7
    private let maxValue = 1.5

    init() {
        manager = CMMotionManager()
        manager.deviceMotionUpdateInterval = 1/60
        manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
            guard let motion = motionData?.attitude else {
                return
            }
            let roll = motion.roll
            let pitch = motion.pitch - self.pitchAdjustment
            guard abs(roll) < self.maxValue,
                  abs(pitch) < self.maxValue else {
                return
            }
            self.x = min(max(roll, -1), 1)
            self.y = min(max(pitch, -1 - self.pitchAdjustment), 1 - self.pitchAdjustment)
        }
    }
    
    deinit {
        manager.stopDeviceMotionUpdates()
    }
}
