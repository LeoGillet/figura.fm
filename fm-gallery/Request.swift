//
//  Request.swift
//  fm-gallery
//
//  Created by Léo Gillet on 19/09/2024.
//
import SwiftUICore

func lastfmRequest(endpoint: String) async throws -> Data? {
    print("Starting lastfmRequest with endpoint \(endpoint)")
    // var userAgent: String {"Figura/\(settings._appVersionBundle).\(settings._appBuildVersionBundle) debug-build"}
    var userAgent: String {"Figura/0.2 debug-build"}
    let apiURL: String = "https://ws.audioscrobbler.com"
    let apiKey: String = "1221e324675b378a1d4161ad660b914d"
    
    guard let url = URL(string: "\(apiURL)\(endpoint)&api_key=\(apiKey)") else { fatalError("URL entered is invalid") }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.setValue(userAgent, forHTTPHeaderField: "User-Agent")
    
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error occured during request: \(url)")}
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
    return response.recenttracks
}


func requestAndDecodeTopAlbums(user: String, period: String) async throws -> LastFMAPITopAlbums {
    let endpoint = "/2.0/?method=user.gettopalbums&user=\(user)&period=\(period)&limit=10&format=json"
    guard let data: Data = try await lastfmRequest(endpoint: endpoint) else {
        fatalError("No Data retrieved")
    }
    
    let decoder = JSONDecoder()
    let response = try decoder.decode(LastFMAPITopAlbumsResponse.self, from: data)
    return response.topalbums
}
