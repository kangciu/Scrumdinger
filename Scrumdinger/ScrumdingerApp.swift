/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    // @ 상태 개체 속성을 사용하여 @ 상태 속성을 교체함 (@State => @StateObject) DailyScrum.sampleData => ScrumStore()
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) {
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task { // 작업 수정자가 비동기 함수 호출을 허용한다는 것을 기억하기.
                do { // 나중에 튜토리얼에서 사용자에게 오류 정보를 제시함.
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
