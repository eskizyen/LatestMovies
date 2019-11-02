import Foundation

protocol RemoteEncoderProtocol {
    func encode<T: Encodable>(model: T) throws -> Data
}

extension Remote {
    struct Encoder {
        struct Json: RemoteEncoderProtocol {
            func encode<T: Encodable>(model: T) throws -> Data {
                let encoder = JSONEncoder()
                return try encoder.encode(model)
            }
        }
    }
}
