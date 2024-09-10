import SwiftUI

struct TopicDetails: View {
    @State var vm: TopicDetailsViewModel
    
    init(topic: Topic) {
        self.vm = TopicDetailsViewModel(topic: topic)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Header()
                PhotoGrid(
                    photos: vm.photos,
                    spacing: 8,
                    onLastItemApear: vm.load
                ).padding(.horizontal)
                if vm.isLoading {
                    ProgressView()
                }
            }
        }
        .navigationTitle(vm.topic.title)
        .onAppear(perform: vm.load)
    }
    
    @ViewBuilder
    func Header() -> some View {
        let topic = vm.topic
        
        PhotoImageView(photo: topic.coverPhoto)
            .aspectRatio(CGFloat(topic.coverPhoto.ratio), contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
        
        VStack(alignment: .leading) {
            Text(topic.title)
                .font(.title)
                .bold()
            HStack {
                Text("Created by")
                    .foregroundStyle(.secondary)
                Text(topic.owners.map{$0.name}.joined(separator: ", "))
                    .fontWeight(.medium)
            }
            if let description = topic.description {
                Text(description.trimmingCharacters(in: .whitespacesAndNewlines))
                    .font(.body)
            }
            Button("Submit to \(topic.title)", action: {})
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .fontWeight(.semibold)
            HStack {
                Text("\(topic.totalPhotos) images")
                    .fontWeight(.medium)
                Spacer()
                Button(
                    action: {},
                    label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                )
            }.padding(.vertical)
        }
        .padding(.horizontal)
    }
}

#Preview {
    TopicDetails(topic: Topic.samples[2]).environment(AppRoute())
}
