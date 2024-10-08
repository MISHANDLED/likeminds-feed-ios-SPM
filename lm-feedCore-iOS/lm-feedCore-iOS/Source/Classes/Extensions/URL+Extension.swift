//
//  URL+Extension.swift
//  lm-feedCore-iOS
//
//  Created by Devansh Mohata on 22/01/24.
//

import Foundation

public extension URL {
    var isDirectory: Bool {
        (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
    
    var queryParameters: [String: String] {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else { return [:] }
        
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
    
    func getFileSize() -> Int {
        guard isFileURL else { return 0 }
        
        do {
            _ = self.startAccessingSecurityScopedResource()
            let size = try resourceValues(forKeys: [.fileSizeKey]).fileSize
            self.stopAccessingSecurityScopedResource()
            return size ?? 0
        } catch {
            print("File Size Failed")
        }
        
        return 0
    }
    
    
}
