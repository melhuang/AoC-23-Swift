import Foundation

public protocol Parseable {
    init(input: String)
}

public struct FileLoader {
    private init() { }
    
    // Keep around in case we need to fallback to it.
public static func load(file: String) -> [String]? {
        guard let fileUrl = Bundle.main.url(forResource: file, withExtension: "txt") else {
            return nil
        }
        
        guard let content = try? String(contentsOf: fileUrl, encoding: .utf8).components(separatedBy: "\n") else {
            return nil
        }
        
        return content
    }
    
    public static func load<T: Parseable>(file: String) -> [T] {
        let fileUrl = Bundle.main.url(forResource: file, withExtension: "txt")!
        let content = try! String(contentsOf: fileUrl, encoding: .utf8)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
        return content.map(T.init)
    }
}
