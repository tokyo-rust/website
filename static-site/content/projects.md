+++
title = "Community Projects"
template = "projects.html"
description = "Check out projects built by Tokyo Rust community members! From tools and libraries to applications and experiments, our members are creating amazing things with Rust."


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
