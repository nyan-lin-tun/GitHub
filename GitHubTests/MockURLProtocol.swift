//
//  MockURLProtocol.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 14/5/25.
//


class MockURLProtocol: URLProtocol {
        static var mockData: Data?
        static var mockResponse: URLResponse?

        override class func canInit(with request: URLRequest) -> Bool {
            return true
        }

        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }

        override func startLoading() {
            if let response = Self.mockResponse {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = Self.mockData {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        }

        override func stopLoading() {}
    }