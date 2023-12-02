import Foundation

public protocol Parseable {
    init(input: String)
}

public struct FileLoader {
    private init() { }
    
    // Keep around in case we need to fallback to it.
    public static func load(file: String) -> [String]? {
        guard let fileUrl = Bundle.module.url(
            forResource: file,
            withExtension: "txt",
            subdirectory: "Data"
        ) else {
            return nil
        }
        
        guard let content = try? String(contentsOf: fileUrl, encoding: .utf8).components(separatedBy: "\n") else {
            return nil
        }
        
        return content
    }
    
    public static func load<T: Parseable>(file: String) -> [T] {
        let fileUrl = Bundle.module.url(
            forResource: file,
            withExtension: "txt",
            subdirectory: "Data"
        )!
        let content = try! String(contentsOf: fileUrl, encoding: .utf8)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
        return content.map(T.init)
    }
}
