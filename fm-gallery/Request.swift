//
//  Request.swift
//  fm-gallery
//
//  Created by Léo Gillet on 19/09/2024.
//
import SwiftUICore

@propertyWrapper
public struct CodableIgnored<T>: Codable {
    public var wrappedValue: T?
        
    public init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        self.wrappedValue = nil
    }
    
    public func encode(to encoder: Encoder) throws {
        // Do nothing
    }
}

extension KeyedDecodingContainer {
    public func decode<T>(
        _ type: CodableIgnored<T>.Type,
        forKey key: Self.Key) throws -> CodableIgnored<T>
    {
        return CodableIgnored(wrappedValue: nil)
    }
}

extension KeyedEncodingContainer {
    public mutating func encode<T>(
        _ value: CodableIgnored<T>,
        forKey key: KeyedEncodingContainer<K>.Key) throws
    {
        // Do nothing
    }
}

struct LastFMAPIArtist: Codable, Identifiable {
    var id: String {text}
    let mbid: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case mbid
        case text = "#text"
    }
}

struct LastFMAPIAlbum: Codable, Identifiable {
    var id: String {"\(text) (\(mbid))"}
    let mbid: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case mbid
        case text = "#text"
    }
}

struct LastFMAPIImage: Codable, Identifiable {
    var id: String { size }
    let size: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case size
        case text = "#text"
    }
}

struct LastFMAPITrackAttr: Codable {
    let nowplaying: String
}

struct LastFMAPITrack: Codable, Identifiable {
    var id: String {"\(artist.text) - \(name)"}
    let artist: LastFMAPIArtist
    let streamable: String
    let image: [LastFMAPIImage]
    let mbid: String
    let album: LastFMAPIAlbum
    let name: String
    let url: String
    let attr: LastFMAPITrackAttr?
    
    enum CodingKeys: String, CodingKey {
        case artist
        case streamable
        case image
        case mbid
        case album
        case name
        case url
        case attr = "@attr"
    }
}

struct LastFMAPIRecentTracksAttr: Codable {
    let user: String
    let totalPages: String
    let page: String
    let perPage: String
    let total: String
}

struct LastFMAPIRecentTracks: Codable {
    let tracks: [LastFMAPITrack]
    
    private enum CodingKeys: String, CodingKey {
        case tracks = "track"
    }
}

struct LastFMAPIRecentTracksResponse: Codable {
    let recenttracks: LastFMAPIRecentTracks
    @CodableIgnored var attr: LastFMAPIRecentTracksAttr?
    
    private enum CodingKeys: String, CodingKey {
        case recenttracks
    }
}

func lastfmRequest(endpoint: String) async throws -> Data? {
    print("Starting lastfmRequest with endpoint \(endpoint)")
    @EnvironmentObject var settings: Settings
    let apiURL: String = "https://ws.audioscrobbler.com"
    let apiKey: String = "1221e324675b378a1d4161ad660b914d"
    
    guard let url = URL(string: "\(apiURL)\(endpoint)&api_key=\(apiKey)") else { fatalError("URL entered is invalid") }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error occured during request: \(endpoint)")}
    print("lastfmRequest: \(url) returned \(String(describing: (response as? HTTPURLResponse)?.statusCode)): \(data)")
    return data
}

func requestAndDecodeRecentTracks(user: String) async throws -> LastFMAPIRecentTracks {
    print("Starting requestAndDecodeRecentTracks with user \(user)")
    let endpoint = "/2.0/?method=user.getrecenttracks&user=\(user)&format=json"
    guard let data: Data = try await lastfmRequest(endpoint: endpoint) else {
        print("No Data retrieved")
        fatalError("No Data retrieved")
    }
    let decoder = JSONDecoder()
    let response = try decoder.decode(LastFMAPIRecentTracksResponse.self, from: data)
    print(response)
    return response.recenttracks
}
