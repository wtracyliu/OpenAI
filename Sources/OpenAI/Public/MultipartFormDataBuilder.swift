//
//  MultipartFormDataBuilder.swift
//  CopyRight: https://github.com/dylanshine/openai-kit/blob/main/Sources/OpenAIKit/Request%20Handler/MultipartFormDataBuilder.swift
//

import Foundation

struct MultipartFormDataBuilder {
    private let boundary: String
    private var httpBody = NSMutableData()
    
    init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
    }
    
    func addDataField(fieldName: String, fileName: String, data: Data, mimeType: String) {
        var fieldData = Data("--\(boundary)\r\n".data(using: .utf8)!)
        fieldData.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        fieldData.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        fieldData.append(data)
        fieldData.append("\r\n".data(using:.utf8)!)
        httpBody.append(fieldData)
    }
    
    func addTextField(name: String, value: String) {
        var fieldData = Data("--\(boundary)\r\n".data(using: .utf8)!)
        fieldData.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
        fieldData.append("\(value)".data(using: .utf8)!)
        fieldData.append("\r\n".data(using: .utf8)!)
        fieldData.append("--\(boundary)--\r\n".data(using: .utf8)!)
        httpBody.append(fieldData)
    }
    
    func build() -> Data {
        httpBody.append(Data("--\(boundary)--".utf8))
        return httpBody as Data
    }
    
}
