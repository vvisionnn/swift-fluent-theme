import ProjectDescription

// Marks `Examples/` as a self-contained Tuist project root, independent of the
// surrounding Swift package. Uses all defaults — no Tuist Cloud, no plugins.
let tuist = Tuist(project: .tuist())
