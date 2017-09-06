//
//  ModularContentBlock.swift
//  Pods
//
//  Created by Martin Makarsky on 05/09/2017.
//
//

public class ModularContentBlock: Block {
    public private(set) var contentItemName: String?
    
    init?(html: String?) {
        if let objectTag = html {
            if (isModularContent(objectTag: objectTag)) {
                if let contentItemName = getModularContentName(objectTag: html) {
                    self.contentItemName = contentItemName
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    private func isModularContent(objectTag: String) -> Bool {
        let objectPattern = "<object type=\"application/kenticocloud\" data-type=\"item\""
        if objectTag.hasPrefix(objectPattern) {
            return true
        }
        
        return false
    }
    
    private func getModularContentName(objectTag: String?) -> String? {
        if let objectTag = objectTag {
            let startSeq = "data-codename=\""
            let endSeq = "\">"
            if let name = objectTag.slice(from: startSeq, to: endSeq) {
                return name
            }
        }
        
        return nil
    }
}
