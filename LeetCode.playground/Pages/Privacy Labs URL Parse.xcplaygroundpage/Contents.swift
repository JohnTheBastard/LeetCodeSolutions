import Foundation

typealias ResponseParams = [String:String]

struct ResponseParser {
    let url: URL

    var params: ResponseParams? {
        var _responseParams: ResponseParams?

        if let components = URLComponents(url: self.url, resolvingAgainstBaseURL: false),
            let params = components.queryItems {

            _responseParams = params.reduce(into: ResponseParams()) { (dictionary, item) in
                dictionary[item.name] = item.value ?? String()
            }
        }

        return _responseParams
    }

    init?(_ urlString: String) {
        if let url = URL(string: urlString) {
            self.url = url
        } else {
            return nil
        }
    }
}

let responseURLString = "https://www.surveymonkey.com/endpage?action=next_survey&reward=1525&message=goodjob2"

let responseParams = ResponseParser(responseURLString)?.params

assert(responseParams! == ["reward": "1525", "action": "next_survey", "message": "goodjob2"])

