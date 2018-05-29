//
//  FacebookData.swift
//  Facebook
//
//  Created by JangDoRi on 2018. 5. 23..
//  Copyright © 2018년 piano. All rights reserved.
//

import SwiftyJSON

/// Facebook의 data type protocol.
public protocol FacebookData {
    
    var data: JSON {get set}
    /// 이 data의 id값.
    var id: String {get}
    /// 이 data를 page관리자가 작성했는지의 여부를 반환한다.
    var isAdmin: Bool {get}
    /// 이 data의 message값.
    var message: String {get}
    /// 이 data의 time값. (ISO8601)
    var time: Date {get}
    
}

public extension FacebookData {
    
    public var id: String {
        return data["id"].string ?? ""
    }
    public var isAdmin: Bool {
        return data["from"].dictionary != nil
    }
    public var message: String {
        return data["message"].string ?? ""
    }
    public var time: Date {
        guard let create = data["created_time"].string else {return Date()}
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate,
                                   .withTime, .withColonSeparatorInTime]
        guard let date = formatter.date(from: create) else {return Date()}
        return date
    }
    
}

/// Facebook의 post data.
public struct PostData: FacebookData {
    
    public var data: JSON
    /// PostData가 section data인지의 여부.
    public var isSection: Bool
    
}

/// Facebook의 comment data.
public struct CommentData: FacebookData {
    
    public var data: JSON
    /// CommentData가 하위 replyData를 가지는지의 여부.
    public var hasReply: Bool
    /// CommentData가 가지는 reply data의 갯수.
    public var replyCount: Int {
        return data["comment_count"].int ?? 0
    }
    
}

/// Facebook의 reply data.
public struct ReplyData: FacebookData {
    
    public var data: JSON
    /// ReplyData가 속하는 comment data의 id값.
    public var parentId: String
    /// ReplyData의 추가적인 request에서 다음 data 위치를 지시하는 cursor값.
    public var hasCursor: String!
    
}

