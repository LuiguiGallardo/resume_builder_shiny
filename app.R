library(shiny)
library(vitae)
library(tibble)
library(dplyr)
library(rmarkdown)

# Define UI
ui <- fluidPage(
  theme = bslib::bs_theme(version = 5, bootswatch = "lux"),
  titlePanel("CV Editor & PDF Generator"),
  
  sidebarLayout(
    sidebarPanel(
      width = 4,
      h4("1. Profile Header"),
      textInput("name", "Name", "Luigui"),
      textInput("surname", "Surname", "Gallardo-Becerra"),
      textInput("position", "Position", "Molecular Biologist | Bioinformatician"),
      textInput("phone", "Phone", "+1 619 602 0725"),
      textInput("email", "Email", "luiguimichelgallardo@gmail.com"),
      textInput("www", "Website", "www.lmgb.xyz"),
      textInput("github", "GitHub", "LuiguiGallardo"),
      textInput("linkedin", "LinkedIn", "luiguigallardo"),
      
      hr(),
      h4("2. About Me"),
      textAreaInput("aboutme", NULL, 
                    value = "Molecular Biologist and Bioinformatician with 6+ years of experience integrating wet-lab techniques with advanced computational analysis. Skilled in experimental design, NGS library preparation, PCR/qPCR, microbial culture, and molecular cloning, combined with strong expertise in genomics, transcriptomics, and microbiome analysis. Experienced in building reproducible bioinformatics workflows and analyzing large-scale biological datasets to generate actionable scientific insights. Author of 13 peer-reviewed publications and contributor to interdisciplinary projects across molecular biology, microbiology, and computational biology.", 
                    rows = 8),
      
      hr(),
      h4("3. Experience Details"),
      helpText("Edit the bullet points for your primary role:"),
      textAreaInput("exp_bullets", "Research Assistant Details", 
                    value = "**Bioinformatics workflow support:** Designed and maintained reproducible data-processing workflows using Snakemake, Nextflow, and Bash to support molecular biology and genomics projects.\n\n**NGS data interpretation:** Analyzed next-generation sequencing datasets—including RNA-seq, whole genome sequencing, 16S rRNA profiling, metagenomics, and metatranscriptomics—to extract biologically meaningful insights that informed experimental design and downstream validation.\n\n**Microbiome and functional analysis:** Performed taxonomic profiling, functional annotation, and comparative metagenomics to characterize microbial communities and identify gene functions relevant to host–microbe interactions.\n\n**Statistical and machine learning applications:** Applied statistical modeling and supervised/unsupervised learning approaches to identify biomarkers, classify phenotypes, and evaluate molecular signatures.\n\n**Data and database management:** Built and maintained curated biological datasets and internal databases, ensuring high data quality, traceability, and reproducibility across projects.\n\n**High-performance computing operations:** Managed HPC environments used for large-scale sequence analysis, including job scheduling, software installation, workflow optimization, and troubleshooting.\n\n**Custom computational tools:** Developed targeted analysis scripts and utilities in Python, R, Bash, and Perl to streamline laboratory data processing, quality control, and reporting.", 
                    rows = 10),
      
      hr(),
      h4("4. Skills & Publications"),
      textAreaInput("skills_text", "Key Skills Section", 
                    value = "**Molecular Biology Techniques:** DNA/RNA extraction, PCR/qPCR, gel electrophoresis, NGS library prep, sample QC, bacterial culture, plasmid prep, sterile technique (BSL-2), experimental design.\n\n**NGS & Genomics Analysis:** QC (FastQC, MultiQC), read alignment (BWA, Bowtie2, HISAT2), variant calling, de novo assembly, RNA-seq, 16S profiling, metagenomics, metatranscriptomics, viromics.\n\n**Bioinformatics & Workflow Development:** Snakemake, Nextflow, QIIME2, Bioconductor, Biopython, samtools, BLAST, Kraken2, reproducible pipelines, ETL automation.\n\n**Programming & Computing:** Python, R, Bash, SQL, Linux/Unix, HPC (SLURM), Docker, Conda, Git/GitHub, AWS, Google Cloud.", 
                    rows = 8),
      
      textAreaInput("pub_text", "Publications", 
                    value = "**Gallardo-Becerra L**, et al. Bioactive plasmid- and phage-encoded antimicrobial peptides (AMPs) in the human gut. Microb Ecol. 2025 Nov 28.\n\n**Gallardo-Becerra L**, et al. Host genome drives the microbiota enrichment of beneficial microbes in shrimp. Anim Microbiome. 2025 May 22.\n\n**Gallardo-Becerra L**, et al. Perspectives in searching antimicrobial peptides (AMPs) produced by the microbiota. Microb Ecol. 2023.\n\n**Gallardo-Becerra L**, et al. Metatranscriptomic analysis to define the Secrebiome... Mexican children. Microb Cell Fact. 2020.\n\n**Gallardo-Becerra L**, et al. A meta-analysis reveals the environmental and host factors shaping the structure and function of the shrimp microbiota. PeerJ. 2018.", 
                    rows = 8),
      
      hr(),
      downloadButton("downloadPDF", "Knit & Download PDF", class = "btn-primary w-100")
    ),
    
    mainPanel(
      width = 8,
      h4("Live R Markdown Preview (Complete Source)"),
      verbatimTextOutput("preview_rmd")
    )
  )
)

# Define Server
server <- function(input, output) {
  
  # Reactive string generating the FULL Rmd exactly as requested
  resume_rmd_content <- reactive({
    paste0(
      "---\n",
      "name: ", input$name, "\n",
      "surname: ", input$surname, "\n",
      "position: \"", input$position, "\"\n",
      "phone: ", input$phone, "\n",
      "www: ", input$www, "\n",
      "email: \"", input$email, "\"\n",
      "github: ", input$github, "\n",
      "linkedin: ", input$linkedin, "\n",
      "date: \"`r format(Sys.time(), '%B %Y')`\"\n",
      "aboutme: \"", input$aboutme, "\"\n",
      "output: vitae::awesomecv\n",
      "---\n\n",
      
      "```{r setup, include=FALSE}\n",
      "knitr::opts_chunk$set(echo = FALSE, warning = FALSE, message = FALSE)\n",
      "library(vitae); library(tibble); library(dplyr)\n",
      "```\n\n",
      
      "# Research Experience\n\n",
      "```{r}\n",
      "tribble(\n",
      "  ~ empty, ~ Degree, ~ Year, ~ Institution,\n",
      "  \"\", \"Research Assistant (Molecular Biology & Bioinformatics)\", \"January 2019 - July 2025\", \"Institute of Biotechnology, UNAM\"\n",
      ") %>% detailed_entries(empty, Year, Degree, Institution)\n",
      "```\n",
      input$exp_bullets, "\n\n",
      
      "```{r}\n",
      "tribble(\n",
      "  ~ empty, ~ Degree, ~ Year, ~ Institution,\n",
      "  \"\", \"Data Engineer\", \"October 2016 - December 2018\", \"Appen\"\n",
      ") %>% detailed_entries(empty, Year, Degree, Institution)\n",
      "```\n",
      "Supported large-scale data processing projects by developing automated ETL pipelines to ensure efficient integration and cleaning of high-volume datasets.\n\n",
      
      "```{r}\n",
      "tribble(\n",
      "  ~ empty, ~ Degree, ~ Year, ~ Institution,\n",
      "  \"\", \"Software Engineer (Internship)\", \"January 2016 - July 2016\", \"Dept. of Computer Science, CUCEI\"\n",
      ") %>% detailed_entries(empty, Year, Degree, Institution)\n",
      "```\n",
      "Developed a cloud-based web application using ASP.NET Core for managing patient records and clinical data.\n\n",
      
      "# Education\n",
      "```{r}\n",
      "tribble(\n",
      "  ~ Degree, ~ Year, ~ Institution, ~ Where,\n",
      "  \"Ph.D. in Computational Biology\", \"January 2019 - July 2025\", \"National Autonomous University of Mexico (UNAM)\", \"Mexico City, Mexico\",\n",
      "  \"Master of Science in Computational Biology\", \"August 2016 - January 2019\", \"National Autonomous University of Mexico (UNAM)\", \"Mexico City, Mexico\",\n",
      "  \"Bachelor of Science in Molecular Biology\", \"August 2012 - January 2016\", \"University of Guadalajara (UDG)\", \"Guadalajara, Mexico\"\n",
      ") %>% detailed_entries(Degree, Year, Institution, Where)\n",
      "```\n\n",
      
      "# Key Skills\n\n",
      input$skills_text, "\n\n",
      
      "# Selected Publications (14 total)\n\n",
      input$pub_text, "\n"
    )
  })
  
  output$preview_rmd <- renderText({
    resume_rmd_content()
  })
  
  output$downloadPDF <- downloadHandler(
    filename = function() { paste0("CV_Luigui_Gallardo_", Sys.Date(), ".pdf") },
    content = function(file) {
      build_dir <- file.path(tempdir(), paste0("cv_gen_", as.numeric(Sys.time())))
      dir.create(build_dir)
      temp_rmd <- file.path(build_dir, "resume.Rmd")
      writeLines(resume_rmd_content(), temp_rmd)
      
      tryCatch({
        rmarkdown::render(temp_rmd, output_file = "resume.pdf", envir = new.env(parent = globalenv()))
        file.copy(file.path(build_dir, "resume.pdf"), file)
      }, error = function(e) {
        message(e)
        showNotification("Knit failed. Check LaTeX dependencies.", type = "error")
      })
    }
  )
}

shinyApp(ui = ui, server = server)