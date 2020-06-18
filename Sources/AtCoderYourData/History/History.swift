import Foundation
import FoundationNetworking

import Kanna

struct History {
    struct Data { 
        var date: String
        var contest: String
        var rank: Int
        var perf: Int?
        var rating: Int?
        var diff: Int?

        init(data: [String]) {
            self.date = data[0]
            self.contest = data[1]
            self.rank = Int(data[2])!
            self.perf = Int(data[3])
            self.rating = Int(data[4])
            self.diff = Int(data[5])
        }
    }
    let rows: [History.Data]?
    let columns: (date: [String], contest: [String], rank: [Int], perf: [Int?], rating: [Int?], diff: [Int?])?

    init(userId: String) throws {
        do {
            let url = URL(string: "https://atcoder.jp/users/\(userId)/history")!
            let doc = try HTML(url: url, encoding: .utf8)
            if let table = doc.xpath("//table").first {
                let trs = table.xpath("//tr").filter { $0.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" }
                let data: [Data] = trs[1...].compactMap { tr in 
                    if let data = (tr.text?
                                     .split(separator: "\n")
                                     .map{ $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                                     .filter { $0 != "" })
                    {
                        return History.Data(data: data)
                    } else {
                        return nil
                    }
                }

                self.rows = data
                self.columns = (
                    date: data.map { $0.date },
                    contest: data.map { $0.contest },
                    rank: data.map { $0.rank },
                    perf: data.map { $0.perf },
                    rating: data.map { $0.rating },
                    diff: data.map { $0.diff }
                )
            } else {
                self.rows = nil
                self.columns = nil
            }
        } catch {
            throw error
        }
    }
}
