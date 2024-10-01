import UniformTypeIdentifiers
import SwiftUI
import os


// Taken from:
// https://developer.apple.com/documentation/swiftui/referencefiledocument

final class PDFDocument: ReferenceFileDocument {
    static let readableContentTypes:  [UTType] = [.pdf]
    static let writeableContentTypes: [UTType] = []
    
    struct Storage {
        var contents: Data
    }

    // https://developer.apple.com/documentation/os/osallocatedunfairlock
    let storage: OSAllocatedUnfairLock<Storage>


    required init(configuration: ReadConfiguration) throws {
       guard let data = configuration.file.regularFileContents else {
           throw CocoaError(.fileReadCorruptFile)
       }
        
        self.storage = .init(initialState: .init(contents: data))
    }


    func snapshot(contentType: UTType) throws -> Data {
        storage.withLock { $0.contents }
    }


    func fileWrapper(snapshot: Data, configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: snapshot)
    }
}
