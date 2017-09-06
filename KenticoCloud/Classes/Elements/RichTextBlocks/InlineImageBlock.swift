//
//  InlineImageBlock.swift
//  Pods
//
//  Created by Martin Makarsky on 06/09/2017.
//
//

public class InlineImageBlock: Block {
    public private(set) var description: String?
    public private(set) var url: String?
    
    init?(html: String?) {
        if let tag = html {
            if (isInlineImageBlock(figureTag: tag)) {
                if let description = getDescription(figureTag: tag) {
                    self.description = description
                }
                if let url = getUrl(figureTag: tag) {
                    self.url = url
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    private func isInlineImageBlock(figureTag: String?) -> Bool {
        let figurePattern = "<figure data-image-id=\""
        if let tag = figureTag {
            if tag.hasPrefix(figurePattern) {
                return true
            }
        }
        
        return false
    }
    
    private func getUrl(figureTag: String?) -> String? {
        if let figuretTag = figureTag {
            let startSeq = "<img src=\""
            let endSeq = "\""
            if let url = figuretTag.slice(from: startSeq, to: endSeq) {
                return url
            }
        }
        
        return nil
    }
    
    private func getDescription(figureTag: String?) -> String? {
        if let figuretTag = figureTag {
            let startSeq = "alt=\""
            let endSeq = "\""
            if let description = figuretTag.slice(from: startSeq, to: endSeq) {
                return description
            }
        }
        
        return nil
    }
}
