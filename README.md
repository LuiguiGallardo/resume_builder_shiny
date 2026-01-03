# Resume Builder Shiny App

A Shiny application to create and download professional CVs using the `vitae` package.

## Features
- **Interactive Editor**: Edit personal info, experience, skills, and publications.
- **PDF Generation**: Renders a polished PDF resume based on the "AwesomeCV" template.
- **Live Preview**: View the generated R Markdown source in real-time.

## Usage
1. Install dependencies: `shiny`, `vitae`, `tibble`, `dplyr`, `rmarkdown`.
2. Ensure LaTeX is installed (e.g., `tinytex::install_tinytex()`).
3. Run the app: `shiny::runApp()`
