//
//  LastFMAPITypes.swift
//  fm-gallery
//
//  Created by Léo Gillet on 24/09/2024.
//


struct LastFMAPITrackArtist: Codable, Identifiable {
    var id: String {text}
    let mbid: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case mbid
        case text = "#text"
    }
}


struct LastFMAPITrackAlbum: Codable, Identifiable {
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

struct LastFMAPITrack: Identifiable, Codable {
    var id: String { "\(name) (\(mbid))" }
    let artist: LastFMAPITrackArtist
    let streamable: String
    let images: [LastFMAPIImage]
    let mbid: String
    let album: LastFMAPITrackAlbum
    let name: String
    let url: String
    let attr: LastFMAPITrackAttr?
    
    enum CodingKeys: String, CodingKey {
        case artist, streamable, mbid, album, name, url
        case images = "image"
        case attr = "@attr"
    }
}

struct LastFMAPIRequestAttr: Codable {
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
    @CodableIgnored var attr: LastFMAPIRequestAttr?
    
    private enum CodingKeys: String, CodingKey {
        case recenttracks
    }
}

struct LastFMAPITopAlbumsArtist: Codable {
    let name: String
    let mbid: String
    let url: String
}

struct LastFMAPITopAlbumsAttr: Codable {
    let rank: String
}

struct LastFMAPITopAlbumsAlbum: Codable, Identifiable {
    var id: String { "\(name) (\(mbid))" }
    let name: String
    let artist: LastFMAPITopAlbumsArtist
    let images: [LastFMAPIImage]
    let mbid: String
    let url: String
    let playcount: String
    let attr: LastFMAPITopAlbumsAttr
    
    private enum CodingKeys: String, CodingKey {
        case name, artist, mbid, url, playcount
        case images = "image"
        case attr = "@attr"
    }
}

struct LastFMAPITopAlbums: Codable {
    let albums: [LastFMAPITopAlbumsAlbum]
    
    private enum CodingKeys: String, CodingKey {
        case albums = "album"
    }
}

struct LastFMAPITopAlbumsResponse: Codable {
    let topalbums: LastFMAPITopAlbums
    @CodableIgnored var attr: LastFMAPIRequestAttr?
    
    private enum CodingKeys: String, CodingKey {
        case topalbums
    }
}
