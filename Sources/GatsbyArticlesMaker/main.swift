import Foundation
import Swiftline
import ColorizeSwift
import CommandLineKit

enum ContentType: String {
    case Article
    case Page
    case Tag
}

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
    choices: ContentType.Article.rawValue, ContentType.Page.rawValue, ContentType.Tag.rawValue)
switch choice {
case ContentType.Article.rawValue:
    print("Right choice!")
case ContentType.Page.rawValue:
    print("Page")
default:
    print("Ok")
}

// print(fileName.value!)
let fileManager = FileManager.default
let directoryPath = userDirectoryPath.value ?? fileManager.currentDirectoryPath

let currentDate = Date()
let format = DateFormatter()
format.dateFormat = "yyyy-MM-dd"
let formattedDate = format.string(from: currentDate)
format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
let formattedDateAndTime = format.string(from: currentDate)

let folderPath = directoryPath + "/" + formattedDate + "---" + formattedFolderName

do {
    try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: false, attributes: nil)
} catch {
    cli.printUsage(error)
}

var fileContent = String()
fileContent += "---\n"
fileContent += "title: \(folderName)\n"
fileContent += "date: \"\(formattedDateAndTime)\"\n"
fileContent += "layout: post\n"
fileContent += "draft: false\n"
fileContent += "path: \"/posts/\(formattedFolderName.lowercased())/\"\n"
fileContent += "category: \"Blog\"\n"
fileContent += "tags:\n"
fileContent += " - \"<your tag>\"\n"
fileContent += "description: \"your description\"\n"
fileContent += "---\n"

do {
    try fileContent.write(toFile: folderPath + "/index.md", atomically: true, encoding: .utf8)
} catch {
    cli.printUsage(error)
}

// print(path)
