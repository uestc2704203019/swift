//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_exported import ARKit

@available(iOS, introduced: 11.0)
extension ARCamera {
    /**
     A value describing the camera's tracking state.
     */
    public enum TrackingState {
        public enum Reason {
            /** Tracking is limited due to initialization in progress. */
            case initializing
            
            /** Tracking is limited due to a excessive motion of the camera. */
            case excessiveMotion
            
            /** Tracking is limited due to a lack of features visible to the camera. */
            case insufficientFeatures
        }
        
        /** Tracking is not available. */
        case notAvailable
        
        /** Tracking is limited. See tracking reason for details. */
        case limited(Reason)
        
        /** Tracking is normal. */
        case normal
    }
    
    /**
     The tracking state of the camera.
     */
    public var trackingState: TrackingState {
        switch __trackingState {
        case .notAvailable: return .notAvailable
        case .normal: return .normal
        case .limited:
            let reason: TrackingState.Reason
            
            switch __trackingStateReason {
            case .initializing: reason = .initializing
            case .excessiveMotion: reason = .excessiveMotion
            default: reason = .insufficientFeatures
            }
            
            return .limited(reason)
        }
    }
}

@available(iOS, introduced: 11.0)
extension ARPointCloud {
    /**
     The 3D points comprising the point cloud.
     */
    @nonobjc public var points: [vector_float3] {
        let buffer = UnsafeBufferPointer(start: __points, count: Int(__count))
        return Array(buffer)
    }
    
    /**
     The 3D point identifiers comprising the point cloud.
     */
    @nonobjc public var identifiers: [UInt64] {
        let buffer = UnsafeBufferPointer(start: __identifiers, count: Int(__count))
        return Array(buffer)
    }
}
