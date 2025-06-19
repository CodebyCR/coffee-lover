//import SwiftUI
//
//struct Category {
//    let id = UUID()
//    let name: String
//    let items: [CategoryItem]
//}
//
//struct CategoryItem {
//    let id = UUID()
//    let name: String
//    let description: String
//}
//
//struct CategoryListView: View {
//    @State private var selectedItems = Set<UUID>()
//    @State private var currentCategoryTitle = ""
//    @State private var showQuickNavigation = false
//
//    let categories = [
//        Category(name: "Elektronik", items: [
//            CategoryItem(name: "iPhone 15", description: "Neuestes Apple Smartphone"),
//            CategoryItem(name: "MacBook Pro", description: "Professioneller Laptop"),
//            CategoryItem(name: "iPad Air", description: "Vielseitiges Tablet"),
//            CategoryItem(name: "AirPods Pro", description: "Kabellose Kopfhörer")
//        ]),
//        Category(name: "Kleidung", items: [
//            CategoryItem(name: "T-Shirt", description: "Baumwolle, verschiedene Farben"),
//            CategoryItem(name: "Jeans", description: "Klassische Denim-Hose"),
//            CategoryItem(name: "Pullover", description: "Warmer Strickpullover"),
//            CategoryItem(name: "Sneakers", description: "Sportliche Schuhe")
//        ]),
//        Category(name: "Bücher", items: [
//            CategoryItem(name: "Swift Programming", description: "iOS Entwicklung lernen"),
//            CategoryItem(name: "Design Patterns", description: "Software Architektur"),
//            CategoryItem(name: "Clean Code", description: "Besserer Code schreiben"),
//            CategoryItem(name: "SwiftUI Cookbook", description: "UI Entwicklung mit SwiftUI")
//        ]),
//        Category(name: "Sport", items: [
//            CategoryItem(name: "Laufschuhe", description: "Für Marathon und Jogging"),
//            CategoryItem(name: "Yoga-Matte", description: "Rutschfeste Übungsmatte"),
//            CategoryItem(name: "Hantel-Set", description: "Verschiedene Gewichte"),
//            CategoryItem(name: "Fitness-Tracker", description: "Aktivität und Gesundheit")
//        ]),
//        Category(name: "Küche", items: [
//            CategoryItem(name: "Kaffeemaschine", description: "Automatische Espressomaschine"),
//            CategoryItem(name: "Mixer", description: "Hochleistungs-Standmixer"),
//            CategoryItem(name: "Pfannen-Set", description: "Antihaft-Beschichtung"),
//            CategoryItem(name: "Küchenmesser", description: "Professionelle Kochmesser")
//        ]),
//        Category(name: "Garten", items: [
//            CategoryItem(name: "Rasenmäher", description: "Elektrischer Rasenmäher"),
//            CategoryItem(name: "Gartenschere", description: "Für Hecken und Sträucher"),
//            CategoryItem(name: "Blumentöpfe", description: "Verschiedene Größen"),
//            CategoryItem(name: "Gießkanne", description: "10 Liter Fassungsvermögen")
//        ]),
//        Category(name: "Spielzeug", items: [
//            CategoryItem(name: "LEGO Technic", description: "Komplexe Bausätze"),
//            CategoryItem(name: "Puzzle 1000", description: "Herausfordernde Rätsel"),
//            CategoryItem(name: "Brettspiele", description: "Für die ganze Familie"),
//            CategoryItem(name: "Ferngesteuertes Auto", description: "Hochgeschwindigkeits-RC")
//        ])
//    ]
//
//    var body: some View {
//        NavigationView {
//            ScrollViewReader { proxy in
//                ZStack {
//                    // Main List
//                    List {
//                        ForEach(categories, id: \.id) { category in
//                            Section {
//                                ForEach(category.items, id: \.id) { item in
//                                    CategoryItemRow(
//                                        item: item,
//                                        isSelected: selectedItems.contains(item.id)
//                                    ) {
//                                        toggleSelection(for: item.id)
//                                    }
//                                }
//                            } header: {
//                                CategoryHeader(title: category.name)
//                                    .id("category-\(category.name)")
//                                    .onAppear {
//                                        updateCurrentCategory(category.name)
//                                    }
//                            }
//                        }
//
//                        // Bottom spacer
//                        Color.clear
//                            .frame(height: 100)
//                            .id("bottom")
//                    }
//                    .listStyle(PlainListStyle())
//                    .onAppear {
//                        if let firstCategory = categories.first {
//                            currentCategoryTitle = firstCategory.name
//                        }
//                    }
//
//                    // Quick Navigation Overlay
//                    if showQuickNavigation {
//                        QuickNavigationView(
//                            categories: categories,
//                            onCategoryTap: { categoryName in
//                                withAnimation(.easeInOut(duration: 0.5)) {
//                                    proxy.scrollTo("category-\(categoryName)", anchor: .top)
//                                }
//                                showQuickNavigation = false
//                            },
//                            onClose: {
//                                showQuickNavigation = false
//                            }
//                        )
//                        .transition(.opacity)
//                    }
//
//                    // Floating Action Buttons
//                    VStack {
//                        Spacer()
//                        HStack {
//                            Spacer()
//
//                            VStack(spacing: 12) {
//                                // Scroll to Top Button
//                                Button(action: {
//                                    withAnimation(.easeInOut(duration: 0.7)) {
//                                        if let firstCategory = categories.first {
//                                            proxy.scrollTo("category-\(firstCategory.name)", anchor: .top)
//                                        }
//                                    }
//                                }) {
//                                    Image(systemName: "arrow.up.circle.fill")
//                                        .font(.title2)
//                                        .foregroundColor(.white)
//                                        .background(Circle().fill(Color.blue))
//                                }
//
//                                // Quick Navigation Button
//                                Button(action: {
//                                    withAnimation(.easeInOut(duration: 0.3)) {
//                                        showQuickNavigation.toggle()
//                                    }
//                                }) {
//                                    Image(systemName: showQuickNavigation ? "xmark.circle.fill" : "list.bullet.circle.fill")
//                                        .font(.title2)
//                                        .foregroundColor(.white)
//                                        .background(Circle().fill(Color.green))
//                                }
//
//                                // Scroll to Bottom Button
//                                Button(action: {
//                                    withAnimation(.easeInOut(duration: 0.7)) {
//                                        proxy.scrollTo("bottom", anchor: .bottom)
//                                    }
//                                }) {
//                                    Image(systemName: "arrow.down.circle.fill")
//                                        .font(.title2)
//                                        .foregroundColor(.white)
//                                        .background(Circle().fill(Color.orange))
//                                }
//                            }
//                            .padding()
//                        }
//                    }
//                }
//            }
//            .navigationTitle(currentCategoryTitle.isEmpty ? "Kategorien" : currentCategoryTitle)
//            .navigationBarTitleDisplayMode(.large)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Text("\(selectedItems.count) ausgewählt")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//            }
//        }
//    }
//
//    private func toggleSelection(for itemId: UUID) {
//        if selectedItems.contains(itemId) {
//            selectedItems.remove(itemId)
//        } else {
//            selectedItems.insert(itemId)
//        }
//    }
//
//    private func updateCurrentCategory(_ categoryName: String) {
//        DispatchQueue.main.async {
//            currentCategoryTitle = categoryName
//        }
//    }
//}
//
//struct QuickNavigationView: View {
//    let categories: [Category]
//    let onCategoryTap: (String) -> Void
//    let onClose: () -> Void
//
//    var body: some View {
//        VStack(spacing: 0) {
//            // Header
//            HStack {
//                Text("Schnell-Navigation")
//                    .font(.headline)
//                    .fontWeight(.semibold)
//
//                Spacer()
//
//                Button(action: onClose) {
//                    Image(systemName: "xmark.circle.fill")
//                        .foregroundColor(.gray)
//                        .font(.title2)
//                }
//            }
//            .padding()
//            .background(Color(.systemGray6))
//
//            // Category Grid
//            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
//                ForEach(categories, id: \.id) { category in
//                    Button(action: {
//                        onCategoryTap(category.name)
//                    }) {
//                        VStack(spacing: 8) {
//                            Image(systemName: iconForCategory(category.name))
//                                .font(.title2)
//                                .foregroundColor(.blue)
//
//                            Text(category.name)
//                                .font(.caption)
//                                .fontWeight(.medium)
//                                .foregroundColor(.primary)
//                        }
//                        .frame(height: 60)
//                        .frame(maxWidth: .infinity)
//                        .background(Color(.systemBackground))
//                        .cornerRadius(12)
//                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
//                    }
//                    .buttonStyle(PlainButtonStyle())
//                }
//            }
//            .padding()
//        }
//        .background(Color(.systemGray6))
//        .cornerRadius(16)
//        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
//        .padding()
//    }
//
//    private func iconForCategory(_ categoryName: String) -> String {
//        switch categoryName {
//        case "Elektronik": return "laptopcomputer"
//        case "Kleidung": return "tshirt"
//        case "Bücher": return "book"
//        case "Sport": return "figure.run"
//        case "Küche": return "fork.knife"
//        case "Garten": return "leaf"
//        case "Spielzeug": return "gamecontroller"
//        default: return "folder"
//        }
//    }
//}
//
//struct CategoryHeader: View {
//    let title: String
//
//    var body: some View {
//        HStack {
//            Text(title)
//                .font(.headline)
//                .fontWeight(.semibold)
//                .foregroundColor(.primary)
//
//            Spacer()
//
//            Image(systemName: "folder.fill")
//                .foregroundColor(.blue)
//                .font(.caption)
//        }
//        .padding(.vertical, 4)
//        .textCase(nil)
//    }
//}
//
//struct CategoryItemRow: View {
//    let item: CategoryItem
//    let isSelected: Bool
//    let onTap: () -> Void
//
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading, spacing: 4) {
//                Text(item.name)
//                    .font(.body)
//                    .fontWeight(.medium)
//
//                Text(item.description)
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//                    .lineLimit(2)
//            }
//
//            Spacer()
//
//            Button(action: onTap) {
//                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
//                    .foregroundColor(isSelected ? .blue : .gray)
//                    .font(.title2)
//            }
//            .buttonStyle(PlainButtonStyle())
//        }
//        .padding(.vertical, 2)
//        .contentShape(Rectangle())
//        .onTapGesture {
//            onTap()
//        }
//    }
//}
//
//// Preview
//struct CategoryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryListView()
//    }
//}
