import Foundation
import Swiftline
import ColorizeSwift
import CommandLineKit

private let basePath = "/src/pages"

let cli = CommandLineKit.CommandLine()
let title = StringOption(shortFlag: "t", longFlag: "title", helpMessage: "The title of the file")
let userDirectoryPath = StringOption(shortFlag: "d", longFlag: "directory", helpMessage: "The path for the directory")

cli.addOptions(title)
cli.addOptions(userDirectoryPath)

do {
  try cli.parse()
} catch {
  cli.printUsage(error)
}

guard var folderName = title.value else { fatalError("Error. File name is invalid") }
let formattedFolderName = folderName.replacingOccurrences(of: " ", with: "-")

let choice = choose("What type of the file you want to create? ".colorize(.black, background: .white),
    choices: ContentType.Article.rawValue, ContentType.Page.rawValue)

let contentType = ContentType(with: choice)
let subfolderName = ContentType(with: choice).directoryPath
folderName = contentType == .Article ? folderName : folderName.lowercased()

let fileManager = FileManager.default
let formattedDate = DateUtility.makeDateString()

if let directoryPath = userDirectoryPath.value {
    
    let folderPath = directoryPath + basePath + subfolderName + "/"
    let fullPath = folderPath + formattedDate.date + "---" + formattedFolderName
    
    do {
        try fileManager.createDirectory(atPath: fullPath, withIntermediateDirectories: false, attributes: nil)
    } catch {
        cli.printUsage(error)
    }
    
    let fileContent = FolderUtility.makeFolder(for: folderName, contentType: contentType, formattedDate: formattedDate, postPath: formattedFolderName)
    
    do {
        try fileContent.write(toFile: fullPath + "/index.md", atomically: true, encoding: .utf8)
    } catch {
        cli.printUsage(error)
    }
}
