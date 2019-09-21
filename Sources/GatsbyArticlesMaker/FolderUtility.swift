//
//  FolderUtility.swift
//  GatsbyArticlesMaker
//
//  Created by Ivan Sapozhnik on 9/21/19.
//

import Foundation

struct FolderUtility {
    static func makeFolder(for folderName: String, contentType: ContentType, formattedDate: FormattedDate, postPath: String) -> String {
        switch contentType {
        case .Article:
            return articleContent(for: folderName, contentType: contentType, formattedDate: formattedDate, postPath: postPath)
        case .Page:
            return pageContent(for: folderName, formattedDate: formattedDate, postPath: postPath)
        }
    }
    
    private static func articleContent(for folderName: String, contentType: ContentType, formattedDate: FormattedDate, postPath: String) -> String {
        var fileContent = String()
        fileContent += "---\n"
        fileContent += "title: \(folderName)\n"
        fileContent += "date: \"\(formattedDate.dateAndTime)\"\n"
        fileContent += "layout: post\n"
        fileContent += "draft: false\n"
        
        fileContent += "path: \"\(contentType.directoryPath)/\(postPath.lowercased())/\"\n"
        fileContent += "category: \"Blog\"\n"
        fileContent += "tags:\n"
        fileContent += " - \"<your tag>\"\n"
        fileContent += "description: \"your description\"\n"
        fileContent += "---\n"
        return fileContent
    }
    
    private static func pageContent(for folderName: String, formattedDate: FormattedDate, postPath: String) -> String {
        var fileContent = String()
        fileContent += "---\n"
        fileContent += "title: \(folderName)\n"
        fileContent += "layout: page\n"
        fileContent += "path: \"/\(postPath.lowercased())\"\n"
        fileContent += "---\n"
        
        fileContent += "# This is your new page\n"
        return fileContent
    }
}
