[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md
[home topic]:   ../whatis/ep.md

[↖ Tool][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[jekyll whatis]: /tool/jelly/whatis/ep.md

Related topics

| Topic | Location | Kind |
|-|-|-|



<h1 align="center">List of SSG and Authoring Tools</h1>

The concept of tool

# Index of Tool
- [Jekyll](#jekyll)

# Pure SSG

## Jekyll <a id='jekyll'></a>
- **Definition:** Jekyll is a popular static site generator that powers GitHub Pages. It is designed for building blogs and simple websites and allows for content creation using Markdown and Liquid templates.
- **Language Used:** Ruby
- **Developed By:** Tom Preston-Werner and contributors

**Pros:**
- Seamless integration with GitHub Pages.
- Rich plugin and theme options.

**Cons:**
- Ruby environment setup can be challenging for some.
- Performance can lag with larger sites.

---

## 1. Sphinx
- **Definition:** Sphinx is a powerful documentation generator that uses reStructuredText as its markup language. It is widely used for Python projects and supports multiple output formats like HTML, PDF, and ePub.
- **Language Used:** Python
- **Developed By:** Georg Brandl and contributors

**Pros:**
- Extensive support for cross-references, code documentation, and LaTeX.
- Rich ecosystem with themes and extensions.

**Cons:**
- Can be complex to set up for beginners.
- The learning curve for reStructuredText can be steep.

---

## 2. Docusaurus
- **Definition:** Docusaurus is a static site generator developed by Facebook, specifically designed for documentation websites using React and Markdown. It focuses on providing a simple setup for projects that need documentation.
- **Language Used:** JavaScript (React)
- **Developed By:** Facebook

**Pros:**
- Optimized for documentation with versioning and multi-language support.
- Easy to set up with a clean, responsive design.

**Cons:**
- Limited to React; may not suit those preferring other frameworks.
- Relatively new, so the ecosystem is not as mature as others.

---

## 3. MkDocs
- **Definition:** MkDocs is a simple and fast static site generator designed specifically for project documentation, using Markdown as its markup language. It allows for quick setup and easy customization.
- **Language Used:** Python
- **Developed By:** Tom Christie and contributors

**Pros:**
- Quick to set up with clean themes.
- Built-in live preview and search functionality.

**Cons:**
- Less customizable than some other options.
- Limited to Markdown, which may restrict complex documentation needs.

---

## 4. VuePress
- **Definition:** VuePress is a Vue.js-powered static site generator tailored for technical documentation. It allows users to write in Markdown and enhances it with Vue components for a more interactive experience.
- **Language Used:** JavaScript (Vue)
- **Developed By:** Evan You and contributors

**Pros:**
- Markdown with embedded Vue components for dynamic content.
- SEO-friendly and supports PWA features.

**Cons:**
- Primarily focused on Vue, limiting options for non-Vue developers.
- May require knowledge of Vue for full customization.

---

## 5. GitBook
- **Definition:** GitBook is a modern documentation platform that started as a tool for creating books but has evolved into a collaborative documentation and knowledge base tool that supports Markdown and version control.
- **Language Used:** JavaScript
- **Developed By:** GitBook Inc.

**Pros:**
- Web-based editor with collaborative editing and version control.
- Supports Markdown and self-hosting options.

**Cons:**
- The free version has limitations in features and hosting.
- Some users report performance issues with larger documents.

---

## 6. Hugo
- **Definition:** Hugo is a general-purpose static site generator written in Go, suitable for building documentation, blogs, and other websites. It is known for its speed and flexibility.
- **Language Used:** Go
- **Developed By:** GoHugo.io contributors

**Pros:**
- Extremely fast with quick build times.
- Strong plugin and theme ecosystem.

**Cons:**
- Requires knowledge of Go templating for advanced customization.
- Some themes may have a steep learning curve.

---


## 8. Antora
- **Definition:** Antora is a static site generator designed for managing modular documentation, primarily using AsciiDoc. It is ideal for large projects with multiple repositories and versioning requirements.
- **Language Used:** JavaScript (Node.js)
- **Developed By:** The Antora team

**Pros:**
- Designed for managing multi-repository, versioned documentation.
- Good for large-scale technical documentation setups.

**Cons:**
- Requires knowledge of AsciiDoc, which may not be familiar to all users.
- Setup can be complex for small projects.

---

## 9. Docsify
- **Definition:** Docsify is a lightweight documentation site generator that renders Markdown files dynamically on the client side, making it suitable for quick documentation setups.
- **Language Used:** JavaScript
- **Developed By:** The Docsify team

**Pros:**
- Renders Markdown files dynamically on the client side.
- Suitable for quick setups and integrations.

**Cons:**
- Limited features compared to full static site generators.
- Dependent on client-side rendering, which may impact performance.

---

## 10. Read the Docs
- **Definition:** Read the Docs is a platform that automates the building, versioning, and hosting of documentation created with Sphinx and MkDocs, making it easier for developers to manage their documentation.
- **Language Used:** Python
- **Developed By:** The Read the Docs team

**Pros:**
- Automated builds from code repositories.
- Versioning and hosting for Sphinx and MkDocs projects.

**Cons:**
- Can be confusing to configure for new users.
- Performance may vary based on documentation size.

---

## 11. Gatsby
- **Definition:** Gatsby is a React-based static site generator that uses GraphQL for data querying. It is optimized for performance and allows for the creation of dynamic, data-driven websites.
- **Language Used:** JavaScript (React)
- **Developed By:** Gatsby Inc.

**Pros:**
- Leverages React and GraphQL for creating dynamic, data-driven sites.
- Large plugin ecosystem for sourcing content from various data sources.

**Cons:**
- Can be overkill for simple sites.
- Requires a good understanding of React and GraphQL.

---

## 12. Next.js (Static Export)
- **Definition:** Next.js is a React framework that enables both static site generation and server-side rendering, making it versatile for a wide range of web applications.
- **Language Used:** JavaScript (React)
- **Developed By:** Vercel

**Pros:**
- Supports both static site generation (SSG) and server-side rendering (SSR).
- Integrated support for dynamic routing and API routes.

**Cons:**
- May be complex for users unfamiliar with React.
- Not solely focused on static sites; can lead to unnecessary complexity.

---

## 13. Eleventy (11ty)
- **Definition:** Eleventy is a simpler, more flexible static site generator that works with multiple templating languages like Markdown, Nunjucks, and Liquid, making it easy to use for various projects.
- **Language Used:** JavaScript
- **Developed By:** Zach Leatherman

**Pros:**
- Supports a wide range of templating languages.
- Zero-config setup for quick development.

**Cons:**
- Limited ecosystem compared to other generators.
- May require custom setups for complex projects.

---

## 14. Hexo
- **Definition:** Hexo is a fast, simple, and powerful blog framework that allows developers to build personal blogs with ease using Markdown and a wide range of plugins and themes.
- **Language Used:** JavaScript
- **Developed By:** The Hexo team

**Pros:**
- Fast and simple for building personal blogs.
- Extensive plugin and theme ecosystem.

**Cons:**
- Primarily focused on blogging; less suited for documentation.
- Configuration can become complicated with many plugins.

---

## 15. Pelican
- **Definition:** Pelican is a static site generator written in Python that supports various markup formats, including Markdown and reStructuredText, allowing for flexible content creation.
- **Language Used:** Python
- **Developed By:** The Pelican team

**Pros:**
- Flexible and customizable with plugin support.
- Supports multiple content formats.

**Cons:**
- Requires Python environment setup.
- May not be as fast as other generators.

---

## 16. Jigsaw
- **Definition:** Jigsaw is a static site generator for PHP developers that integrates seamlessly with the Laravel framework, enabling users to build robust static sites.
- **Language Used:** PHP
- **Developed By:** Tighten Co.

**Pros:**
- Integrates seamlessly with the Laravel ecosystem.
- Supports Markdown and Blade templates.

**Cons:**
- Limited to PHP developers; not as versatile as others.
- May require knowledge of Laravel for full utilization.

---

## 17. Nuxt.js (Static Mode)
- **Definition:** Nuxt.js is a framework for creating Vue.js applications that can also generate static sites, offering powerful features for building modern web applications.
- **Language Used:** JavaScript (Vue)
- **Developed By:** The Nuxt.js team

**Pros:**
- Supports static site generation, server-side rendering, and SPA.
- Offers automatic route generation.

**Cons:**
- Requires understanding of Vue.js for effective use.
- More complex for those unfamiliar with Vue.

---

## 18. Zola
- **Definition:** Zola is a static site generator written in Rust, known for its fast build times and minimal setup, making it a good choice for building static sites quickly.
- **Language Used:** Rust
- **Developed By:** The Zola team

**Pros:**
- Fast build times and minimal setup.
- Built-in support for Sass and Table of Contents generation.

**Cons:**
- Smaller community compared to more established generators.
- Limited plugins and themes.

---

## 19. Gridsome
- **Definition:** Gridsome is a Vue.js-powered static site generator that helps developers create fast, SEO-friendly sites, leveraging Vue components and a GraphQL data layer.
- **Language Used:** JavaScript (Vue)
- **Developed By:** Gridsome team

**Pros:**
- Easy for Vue developers to use.
- Optimized for performance and SEO.

**Cons:**
- Smaller ecosystem compared to Gatsby.
- Relatively new, so may lack some advanced features.

---
## 20. Adobe RoboHelp
- **Definition:** Adobe RoboHelp is a help authoring tool that allows users to create, manage, and publish online and printed documentation. It is primarily used for creating user manuals, help systems, and knowledge bases.
- **Language Used:** C++
- **Developed By:** Adobe Systems

**Pros:**
- Robust features for creating responsive HTML5-based content.
- Built-in support for collaboration and version control.
- Extensive output formats, including eBooks and printed manuals.

**Cons:**
- Can be expensive, especially for smaller teams or individual users.
- The interface can be overwhelming for new users.
- Limited flexibility compared to other static site generators.

---


# Tools Similar to RoboHelp

## 1. MadCap Flare
- **Definition:** MadCap Flare is a powerful help authoring tool designed for creating, managing, and publishing documentation and help systems. It supports single-source publishing and allows for content reuse across different outputs.
- **Language Used:** C++
- **Developed By:** MadCap Software

**Pros:**
- Supports advanced features like conditional text and variable content.
- Offers extensive customization options for output formats.

**Cons:**
- Steep learning curve for new users.
- Can be pricey for smaller teams or freelance authors.

---

## 2. HelpNDoc
- **Definition:** HelpNDoc is an easy-to-use help authoring tool that enables users to create help files, user manuals, and documentation. It allows for the generation of various output formats, including CHM, HTML, PDF, and more.
- **Language Used:** C++
- **Developed By:** IBE Software

**Pros:**
- Intuitive interface and straightforward workflow.
- Supports multiple output formats with ease.

**Cons:**
- Lacks some advanced features found in more robust tools.
- Free version has limitations on output formats.

---

## 3. ClickHelp
- **Definition:** ClickHelp is a cloud-based help authoring tool that allows teams to create, host, and manage documentation online. It supports collaboration, versioning, and responsive design for various devices.
- **Language Used:** N/A (Web-based)
- **Developed By:** ClickHelp

**Pros:**
- Collaboration features for teams to work together seamlessly.
- Built-in analytics to track documentation usage.

**Cons:**
- Requires an internet connection, as it is cloud-based.
- Subscription model can become costly over time.

---

## 4. Document360
- **Definition:** Document360 is a knowledge base software that allows teams to create and manage self-service documentation. It is designed to help organizations build and maintain internal and external knowledge bases.
- **Language Used:** N/A (Web-based)
- **Developed By:** Document360

**Pros:**
- User-friendly interface with markdown support.
- Analytics and SEO optimization tools available.

**Cons:**
- Limited formatting options compared to traditional help authoring tools.
- Pricing model may not suit all budgets.

---

## 5. Help+Manual
- **Definition:** Help+Manual is a help authoring tool that provides a range of features for creating online and offline documentation. It supports various output formats and includes a built-in editor for creating content.
- **Language Used:** C++
- **Developed By:** EC Software

**Pros:**
- Easy to use with a visual editor.
- Extensive output options, including web-based and printed formats.

**Cons:**
- Limited collaboration features compared to cloud-based tools.
- Some users report performance issues with larger projects.

---

## 6. Doc-To-Help
- **Definition:** Doc-To-Help is a help authoring and documentation tool that allows users to create, manage, and publish various documentation formats, including HTML, Word, and PDF.
- **Language Used:** N/A (Windows application)
- **Developed By:** ComponentOne (GrapeCity)

**Pros:**
- Supports both print and online documentation.
- Integration with Visual Studio for .NET developers.

**Cons:**
- Windows-only application, limiting cross-platform accessibility.
- Can be complex to set up for new users.

---


# LaTeX and Related Tools

## 1. LaTeX
- **Definition:** LaTeX is a typesetting system commonly used for producing scientific and mathematical documents due to its high-quality output. It allows for precise control over document layout and formatting.
- **Language Used:** TeX
- **Developed By:** Leslie Lamport

**Pros:**
- Excellent for typesetting complex mathematical equations and documents.
- Highly customizable with numerous packages available.

**Cons:**
- Steep learning curve for beginners.
- Requires knowledge of markup language for effective use.

---

## 2. Overleaf
- **Definition:** Overleaf is an online collaborative LaTeX editor that simplifies the process of writing and publishing documents in LaTeX. It offers real-time collaboration and a rich text editor interface.
- **Language Used:** N/A (Web-based)
- **Developed By:** Overleaf Ltd.

**Pros:**
- Real-time collaboration features make it easy for multiple users to work together.
- Easy to use for those new to LaTeX with rich text editing options.

**Cons:**
- Requires an internet connection to access.
- Free version has limitations on storage and features.

---

## 3. TeXShop
- **Definition:** TeXShop is a free LaTeX and TeX editor for macOS that provides a user-friendly interface for writing and compiling LaTeX documents. It integrates a PDF viewer for immediate output feedback.
- **Language Used:** N/A (macOS application)
- **Developed By:** Richard Koch

**Pros:**
- Simple interface tailored for macOS users.
- Integrated PDF viewer for easy document preview.

**Cons:**
- Limited to macOS, which restricts its user base.
- May not support all LaTeX packages out of the box.

---

## 4. MikTeX
- **Definition:** MikTeX is a distribution of TeX/LaTeX for Windows that includes a complete set of tools for editing, compiling, and managing LaTeX documents. It comes with a package manager to install missing packages automatically.
- **Language Used:** N/A (Windows application)
- **Developed By:** Christian Schenk

**Pros:**
- Automatic package installation makes setup easy.
- Comprehensive toolset for Windows users.

**Cons:**
- Primarily Windows-focused; limited cross-platform capabilities.
- Can become large and cumbersome with many installed packages.

---

## 5. LyX
- **Definition:** LyX is a document processor that combines the power of LaTeX with a user-friendly graphical interface, allowing users to create complex documents without needing to write LaTeX code directly.
- **Language Used:** C++
- **Developed By:** The LyX Team

**Pros:**
- WYSIWYG (What You See Is What You Get) interface makes it user-friendly.
- Supports LaTeX features while simplifying the writing process.

**Cons:**
- Can be limiting for users who prefer full LaTeX control.
- Some features may not be fully compatible with all LaTeX packages.

---

## 6. ShareLaTeX (now part of Overleaf)
- **Definition:** ShareLaTeX was an online LaTeX editor that allowed users to collaborate on LaTeX documents in real-time. It has now merged with Overleaf, enhancing its collaborative features.
- **Language Used:** N/A (Web-based)
- **Developed By:** ShareLaTeX Team

**Pros:**
- User-friendly interface with real-time collaboration.
- Easy to integrate with cloud storage solutions.

**Cons:**
- Merged with Overleaf, so it no longer exists as a standalone product.
- Users must transition to Overleaf for continued use.

---

## 7. Pandoc
- **Definition:** Pandoc is a universal document converter that can convert files from one markup format to another, including converting Markdown to LaTeX and vice versa. It is widely used for document conversion tasks.
- **Language Used:** Haskell
- **Developed By:** John MacFarlane

**Pros:**
- Supports a wide range of formats for conversion.
- Highly customizable with filters and templates.

**Cons:**
- Requires familiarity with command-line interfaces for full utilization.
- Some conversions may not always preserve formatting perfectly.

