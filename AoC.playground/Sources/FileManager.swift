import Foundation

public struct FileLoader {
    private init() { }
    
    public static func load(file: String) -> [String]? {
        guard let fileUrl = Bundle.main.url(forResource: file, withExtension: "txt") else {
            return nil
        }
        
        guard let content = try? String(contentsOf: fileUrl, encoding: .utf8).components(separatedBy: "\n") else {
            return nil
        }
        
        return content
    }
}
