+++
title = "Community Projects"
template = "projects.html"
description = "Check out projects built by Tokyo Rust community members! From tools and libraries to applications and experiments, our members are creating amazing things with Rust."

[[extra.project]]
name = "Anodized"
url = "https://github.com/mkovaxx/anodized"
logo_url = "https://raw.githubusercontent.com/mkovaxx/anodized/main/assets/logo.svg"
description = "Specifications are a common ground across correctness tools in the Rust ecosystem. Anodized provides spec annotations that are checked for syntax and type errors at compile time, and have an ergonomic and expressive syntax. Specs are enforced at runtime by default. Integration with other tools like fuzzers and formal verifiers is also on the roadmap."

[[extra.project]]
name = "MFEM-rs"
url = "https://github.com/mkovaxx/mfem-rs"
logo_url = ""
description = "Rust wrapper for MFEM; a free, lightweight, scalable C++ library for finite element methods."

[[extra.project]]
name = "MORK"
url = "https://github.com/trueagi-io/MORK/"
description = "MORK is a data transformation engine designed for applications that need to work with billions of entities efficiently.  Initially designed for symbolic AI applications, to become the back for the [MeTTa language](https://metta.lang), it is now used by a growing list of folks in domains from genomics to financial pattern mining.  MORK stores a space of S-Expressions and provides unification over atoms in the space.  It can be accessed via an hyper-based HTTP server, although some users have linked it directly as a library."

[[extra.project]]
name = "pathmap"
url = "https://github.com/adam-Vandervorst/pathMap/"
description = "Very compact radix-256 trie with shared subtries, concurrent access API, path-algebraic ops such as union, intersection, subtract, etc., a read-only format that maps directly from a file, and a number of other features to make it effective for working with massive amounts of data."

[[extra.project]]
name = "Shizen"
url = "https://github.com/brandonpollack23/shizen-again"
logo_url = "https://github.com/brandonpollack23.png?size=200"
description = "Shizen is a tasklist/task management applicaiton and library with peer to peer synchronization and dependency chains for comprehension and visibility of currently actionable todo items"

[[extra.project]]
name = "Sarekt"
url = "https://github.com/brandonpollack23/sarekt"
logo_url = "https://raw.githubusercontent.com/brandonpollack23/sarekt/master/sarekt_screenshot.png"
description = "A bad renderer implemented with ash/vulkan in rust some years ago"

[[extra.project]]
name = "Unifont-rs"
url = "https://github.com/mkovaxx/unifont-rs"
logo_url = ""
description = "Unifont provides a monochrome bitmap font that covers the entire Unicode Basic Multilingual Plane. Halfwidth glyphs are 8x16, fullwidth are 16x16 pixels. Supports #[no_std] builds."
+++

## Add Your Project

Want to showcase your Rust project? We'd love to feature it! You can add your project in two ways:

### Option 1: Use the Interactive Script (Easiest)

1. Fork and clone [the site](https://github.com/tokyo-rust/website)
1. Activate [mise](https://mise.jdx.dev) to get any necessary dependencies (or simply install [gum](https://github.com/charmbracelet/gum))
1. Run the script: `./scripts/add-project.sh`
1. Follow the prompts to add your project details
1. Submit a pull request with your changes (`gh pr create`)

### Option 2: Manual Edit

1. Fork and Clone the [tokyo-rust website repository](https://github.com/tokyo-rust/website)
2. Edit `content/projects.md` and `content/projects.jp.md`
3. Add a new `[[extra.project]]` entry with your project details:
   - `name`: Your project name
   - `url`: Link to your project repository
   - `logo_url`: (Optional) URL to your project logo or GitHub avatar
   - `description`: Brief description of what your project does
4. Submit a pull request

All projects by Tokyo Rust community members are welcome!
