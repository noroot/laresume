# LaResume

LaTeX framework for building resume.

![](./laresume-logo.png)

## Features

* Configurable
* Designed resume template optimized for ATS 
* Generating pdf file
* Signing resume file with a hash to track resume leaks 

## Setup 

### Install dependencies

#### Linux
* Install pdflatex `apt-get install pdflatex`

#### Mac
* Install pdflatex with brew `brew cask install mactex`

#### Windows

I don't know.

## Usage

### Configuration 

* Copy configuration template `cp example.config.tex config.tex`
* Edit configuration and set your info `emacs config.tex`

There are 3 files to edit
* `config.tex` - configuration strings
* `default-template.tex` - Main CV template file 

Inside `config.tex` you will find variables you can change 

``` tex 
\def\role{ruby}
\def\name{Dmitry Ro}
\def\email{public@falsetrue.io}
\def\site{https://falsetrue.io}
\def\linkedin{https://linkedin.com/in/noroot/}
\def\github{https://github.com/yourusername}
\def\telephone{+##-###-##-###} % use dots for US focused resume format
\def\roletitle{Lead software development manager, Lead software developer.}
\def\brief{A brief summary of your professional background, highlighting your key expertise and years of experience.
Describe your career trajectory, core competencies, and the industries you've worked in.
This section should be 2-4 sentences that capture your professional identity and value proposition.}

% Skills configuration
\def\keyskills{List your key skills here as comma-separated values, e.g., Software Development, Leadership, Team Management, Project Management, etc.}

\def\technologies{List your technologies here as comma-separated values or use line breaks. The template will automatically include role-specific technologies based on your role setting (php, ruby, python, crypto, sec).}

% Footer configuration
\def\showsign{true} % Set to 'true' to show SIGN placeholders, 'false' to hide
\def\showdistributionnotice{true} % Set to 'true' to show "Distribution prohibited", 'false' to hide

% Custom links - add as many as needed using \addlink{Label}{URL}
% \addlink{My Portfolio}{https://portfolio.example.com}
% \addlink{My Blog}{https://blog.example.com}

```

Inside `default.tex` you'll find main body of resume with professional experiences and other sections. 

### Build

* `make build` by default default-template will be used, if you want to change file name pass `TEMPLATE` variable with a filename
* open `_build/default-template.pdf`
* shortcut `make build && open _build/default-template.pdf*`

### Sign

The signature mechanism involves hashing a keyword you enter and inserting it into the document. 
This is basic protection which enables tracking back to identify who leaked your resume.

* `make sign`
* Enter signature string for hash generation
* Every sign logged into `signatures.txt` which is added into `.gitignore` 

### All
* Make everthing together `make all` with default values
* Open `_build/` there will be generated pdf file with the resume

## Example

![./screenshot0.jpeg](./screenshot0.jpeg)
![./screenshot1.png](./screenshot1.png)

## Credits

* [https://falsetrue.io](https://falsetrue.io)
* [https://catwatchdog.com](https://catwatchdog.com)

## License

* GPLv3

