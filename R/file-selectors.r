select.files <- function(directory)
  list.files(directory, recursive=TRUE, all.files=TRUE)

select.dirs <- function(directory)
  list.dirs(directory, recursive=TRUE)

select.git.repositories <- function(directory) {
  directory <- sub('/*$', '', directory)

  if (dir.exists(file.path(directory, '.git'))) directory
  else unlist(sapply(list.dirs(directory, recursive=FALSE),
                     select.git.repositories), use.names=FALSE)
}

REPOSITORY.FILES <- c('^.git$', '^DESCRIPTION$', '^README.*$')
select.repositories <- function(directory) {
  directory <- sub('/*$', '', directory)
  files <- list.dirs(directory, full.names=FALSE, recursive=FALSE)
  matches <- mapply(grepl, rep(REPOSITORY.FILES, each=length(files)),
                    rep(files, length(REPOSITORY.FILES)))
  if (any(matches)) directory
  else unlist(sapply(list.dirs(directory, recursive=FALSE),
                     select.git.repositories), use.names=FALSE)
}
