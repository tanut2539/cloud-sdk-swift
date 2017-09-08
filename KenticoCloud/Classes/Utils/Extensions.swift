//
//  Extensions.swift
//  Pods
//
//  Created by Martin Makarsky on 06/09/2017.
//
//

extension String {
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
    
    func isDeliverUrl() -> Bool {
        if self.hasPrefix(DeliverConstants.liveEndpoint) || self.hasPrefix(DeliverConstants.previewEndpoint) {
            return true
        }
        
        return false
    }
    
    func isDeliverPreviewUrl() -> Bool {
        if self.hasPrefix(DeliverConstants.previewEndpoint) {
            return true
        }
        
        return false
    }
}
