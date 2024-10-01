//
//  PDFViewerDocument.swift
//  PDFViewer
//
//  Created by user on 9/26/24.
//

import SwiftUI
import UniformTypeIdentifiers
import PDFKit


class PDFViewerDocument: ReferenceFileDocument {
    static var readableContentTypes: [UTType] { [.pdf] }
    static var writableContentTypes: [UTType] { [] }
    
    var pdfDocument: PDFKit.PDFDocument?
    
    init() {
        self.pdfDocument = nil
    }
    
    
    required init(configuration: ReadConfiguration) throws {
        guard let fileData = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadUnknown)
        }
        
        DispatchQueue.main.async {
            if let pdfDocument = PDFKit.PDFDocument(data: fileData) {
                self.pdfDocument = pdfDocument
            }
        }
    }
    
    
    func snapshot(contentType: UTType) throws -> PDFViewerDocument {
        return self
    }
    
    
    func fileWrapper(snapshot: PDFViewerDocument, configuration: WriteConfiguration) throws -> FileWrapper {
        guard let data = snapshot.pdfDocument?.dataRepresentation() else {
            throw CocoaError(.fileWriteUnknown)
        }
        return FileWrapper(regularFileWithContents: data)
    }
    
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        throw CocoaError(.featureUnsupported)
    }
}
