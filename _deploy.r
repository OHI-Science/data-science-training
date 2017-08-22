## _deploy.r
## to publish the bookdown book, run this script. Basically, you need to copy the .html output from the master branch into the gh-pages branch. See https://bookdown.org/yihui/bookdown/github.

## **IMPORTANT**: you will need to do a one-time setup of your GitHub Token first: see https://help.github.com/articles/creating-an-access-token-for-command-line-use

## create the book here in the master branch!
bookdown::render_book("index.Rmd", "bookdown::gitbook")

## read in github token outside of repo, generated with url above 
gh_token <- scan('~/.github-token', 'character', quiet = TRUE)
Sys.setenv(GH_TOKEN=gh_token)

## book variables
repo_name <- 'data-science-training'
repo_slug <- sprintf('OHI-Science/%s', repo_name)
repo_url <- sprintf('https://github.com/%s', repo_slug)
dir_gh_pages <- sprintf('~/github/clip-n-ship/%s', repo_name)
dir_master <- sprintf('~/github/%s', repo_name)
dir_master_book <- sprintf('~/github/%s/_book', repo_name)


## clone gh-pages branch to temporary location
unlink(dir_gh_pages, recursive=TRUE, force=TRUE) # delete if temporary location exists
repo <- git2r::clone(url=repo_url, 
                     local_path=normalizePath(dir_gh_pages, mustWork=FALSE), 
                     branch='gh-pages')

## copy master branch _book/*.html files to gh-pages
system(sprintf('cp %s/* %s', dir_master_book, dir_gh_pages))

## NOTE/TODO: may have to update libs/ directory too for formatting. 

## add and commit gh-pages branch
git2r::add(repo, sprintf('%s/*html', dir_gh_pages))
git2r::commit(repo, message=sprintf("updating bookdown from %s@master::_deploy.r", repo_name))

setwd(dir_gh_pages)
system(sprintf('git push https://%s@github.com/%s.git HEAD:%s', 
               gh_token, repo_slug, 'gh-pages'))
setwd(dir_master)
